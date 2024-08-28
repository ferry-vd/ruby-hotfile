# frozen_string_literal: true

class Hotfile
  class Record
    ## Additional Information–Form of Payment Record
    class BAR66 < Record
      def initialize(line)
        super

        sequence_number, payment_information, reserved =
          line.scan(/
            (\d)
            (.{50})
            (.{45})
          /x).flatten

        @data = {
          sequence_number: sequence_number.to_i,
          payment_information: payment_information.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
