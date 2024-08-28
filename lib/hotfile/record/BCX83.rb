# frozen_string_literal: true

class Hotfile
  class Record
    ## 3DS Authentication and Additional Card Payment Information Record
    # ! not tested, I hope this code works at all...
    class BCX83 < Record
      def initialize(line)
        super

        date_of_issue, transaction_number, payment_type, auth_sequence_nr, reserved =
          line.scan(/
            (\d{6})
            (\d{6})
            (.{10})
            (\d{2})
            (.{99})
          /x).flatten

        @data = {
          date_of_issue: Hotfile::Date.new(date_of_issue).to_date,
          transaction_number: transaction_number.to_i,
          auth_sequence_nr: auth_sequence_nr.strip,
          payment_type: payment_type.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
