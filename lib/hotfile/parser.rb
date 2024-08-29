# frozen_string_literal: true

class Hotfile
  ## Functions for parsing HOT file data
  module Parser
    def parse
      return if @file.nil?

      records = @file.lines(chomp: true).map { |line| parse_line line }
      @parse ||= {
        records: records,
        date: records.map { |x| x[:date] }.compact.first,
        doc_nr: records.map { |x| x[:doc_nr] }.compact.first,
        transactions: records.map { |x| x[:transaction] }.compact.uniq.count
      }
    end

    def unparsable
      parse[:records].select! { |x| x[:data].nil? }
    end

    def parse_line(line)
      code1, line_number, code2, payload = line.scan(/([A-Z]{3})(\d{8})(\d{2})(.*)/).flatten
      code = code1 + code2
      line_number = line_number.to_i

      if (10..81).include? code2.to_i
        date, transaction, doc_nr, check_digit, payload =
          payload.scan(/
            (\d{6})
            (\d{6})
            ([A-Z0-9 ]{14})
            (\d)
            (.*)
          /x).flatten
      end

      begin
        record_parser = Hotfile::Record.const_get(code)
      rescue NameError
        # Record type does not have a class implementing it.
      end
      data = record_parser.new(payload).parse if record_parser

      {
        code: { id: code, category: code1, number: code2.to_i },
        line_number: line_number,
        raw_payload: payload.strip,
        date: Hotfile::Date.new(date).to_date,
        transaction: transaction&.to_i,
        doc_nr: doc_nr&.strip,
        check_digit: check_digit&.to_i,
        data: data
      }
    end
  end
end
