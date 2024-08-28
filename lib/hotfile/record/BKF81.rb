# frozen_string_literal: true

class Hotfile
  class Record
    ## Fare Calculation Record
    class BKF81 < Record
      def initialize(line)
        super

        sequence_number, info, reserved =
          line.scan(/
            (\d)
            (.{87})
            (.{8})
          /x).flatten

        @data = {
          sequence_number: sequence_number.to_i,
          info: info.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
