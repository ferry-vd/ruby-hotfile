# frozen_string_literal: true

class Hotfile
  class Record
    ## Additional Card Information Record
    # ! not tested, I hope this code works at all...
    class BCC82 < Record
      def initialize(line)
        super

        date_of_issue, transaction_number, payment_type, transaction_id, reserved =
          line.scan(/
            (\d{6})
            (\d{6})
            (.{10})
            (.{25})
            (.{76})
          /x).flatten

        @data = {
          date_of_issue: Hotfile::Date.new(date_of_issue).to_date,
          transaction_number: transaction_number.to_i,
          transaction_id: transaction_id.strip,
          payment_type: payment_type.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
