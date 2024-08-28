# frozen_string_literal: true

class Hotfile
  class Record
    ## Qualifying Issue Information for Sales Transactions Record
    class BKS46 < Record
      def initialize(line)
        super

        original_doc_nr, original_location, original_date, original_agent_code, e_r, reserved =
          line.scan(/
            (.{14})
            ([A-Z ]{3})
            ([A-Z0-9 ]{7})
            ([\d ]{8})
            (.{49})
            (.{15})
          /x).flatten

        @data = {
          original_issue: {
            doc_nr: original_doc_nr.strip,
            location: original_location.strip,
            date: Hotfile::Date.new(original_date).to_date,
            agent_code: original_agent_code.to_i
          },
          endorsements_restrictions: e_r.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
