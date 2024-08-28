# frozen_string_literal: true

class Hotfile
  # Parses a string integer (possibly overpunched) into a real Integer
  class Integer
    def initialize(int_string)
      @raw_value = +int_string
    end

    def to_i
      temp_string = @raw_value.clone
      overpunch_char = temp_string[-1]
      last_digit = case overpunch_char
                     when '{', '}' then 0
                     when /[0-9]/ then overpunch_char.to_i
                     when /[A-I]/ then overpunch_char.unpack1('c') - 64
                     when /[J-R]/ then overpunch_char.unpack1('c') - 73
                   end
      temp_string[-1] = last_digit.to_s
      temp_string = "-#{temp_string}" if negative?
      temp_string.to_i
    end

    def negative?
      '}JKLMNOPQR'.include? @raw_value[-1]
    end
  end
end
