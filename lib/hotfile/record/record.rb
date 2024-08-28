# frozen_string_literal: true

class Hotfile
  class Record
    ## Records parent class
    class Record
      def initialize(line)
        raise 'invalid line' if line.nil? || line.empty?
      end

      def parse
        @data
      end
    end
  end
end
