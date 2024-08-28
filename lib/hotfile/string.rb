# frozen_string_literal: true

class Hotfile
  ## String data type
  class String
    def initialize(string)
      @raw_value = string
    end

    def to_s
      @raw_value.strip
    end

    def to_i
      Hotfile::Integer.new(@raw_value).to_i
    end
  end
end
