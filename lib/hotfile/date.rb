class Hotfile::Date
  require 'date'

  def initialize(date_string)
    @raw_value = date_string.to_s.strip
  end

  def to_date
    return nil if @raw_value.delete('0') == ''
    case @raw_value.length
      when 0 then nil
      when 5 then Date.strptime(@raw_value, '%d%b')
      when 6 then Date.strptime(@raw_value, '%y%m%d')
      when 7 then Date.strptime(@raw_value, '%d%b%y')
      when 8 then Date.strptime(@raw_value, '%Y%m%d')
      else fail NotImplementedError("Unknown date format: #{@raw_value}")
    end
  end
end