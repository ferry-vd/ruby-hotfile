# frozen_string_literal: true

class Hotfile
  class Record
    ## Related Ticket/Document Information Record
    # ! not tested, I hope this code works at all...
    class BKS45 < Record
      def initialize(line)
        super

        waiver, reason, identifier, date_of_issue, reserved =
          line.scan(/
              (.{14})
              (.{5})
              ([\d ]{4})
              ([\d ]{6})
              (.{67})
            /x).flatten

        @data = {
          waiver: waiver.strip,
          reason_code: reason.strip,
          identifier: identifier.strip,
          date_of_issue: Hotfile::Date.new(date_of_issue).to_date,
          reserved: reserved.strip
        }
      end
    end
  end
end
