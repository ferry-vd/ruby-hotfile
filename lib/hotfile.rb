class Hotfile
  require 'hotfile/date'
  require 'hotfile/integer'
  require 'hotfile/string'
  require 'hotfile/record'

  LINE_LENGTH = 136

  def initialize(file)
    if file.respond_to? :read
      @file = file.read
    else
      @file = File.read file
    end
    @file = @file.delete("\r")
  end

  def size
    @file.size
  end
  alias_method :length, :size
  alias_method :count, :size

  def records
    @file.lines(chomp: true).count
  end
  alias_method :lines, :records

  def parse
    {
      records: @file.lines(chomp: true).map { |line| parse_line line }
    }
  end

  def unparsable
    parse[:records].select! { |x| x[:data].nil? }
  end

  def parse_line(line)
    code1, line_number, code2, payload = line.scan(/([A-Z]{3})(\d{8})(\d{2})(.*)/).flatten
    code = code1 + code2
    line_number = line_number.to_i

    if code2.to_i > 10 && code2.to_i <= 81
      date, transaction, doc_nr, check_digit, payload =
        payload.scan(%r{
          (\d{6})
          (\d{6})
          ([A-Z0-9 ]{14})
          (\d)
          (.*)
        }x).flatten
    end

    begin
      record_parser = Hotfile::Record.const_get(code)
    rescue NameError => e
      # Record type does not have a class implementing it.
    end
    data = record_parser.new(payload).parse if record_parser

    {
      code: code,
      line_number: line_number,
      raw_payload: payload.strip,
      date: Hotfile::Date.new(date).to_date,
      transaction: transaction&.strip,
      doc_nr: doc_nr&.strip,
      check_digit: check_digit&.to_i,
      data: data
    }
  end
end