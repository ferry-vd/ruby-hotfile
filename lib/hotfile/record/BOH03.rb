# frozen_string_literal: true

class Hotfile
  class Record
    ## (Reporting Agent) Office Header Record
    class BOH03 < Record
      def initialize(line)
        super

        agent_code, remittance_end_date, currency, location_id, reserved =
          line.scan(/
            (\d{8})
            (\d{6})
            ([A-Z0-9]{4})
            ([A-Z0-9 ]{3})
            (.{102})
          /x).flatten

        @data = {
          currency: currency.strip,
          agent_code: agent_code.to_i,
          remittance_end_date: Hotfile::Date.new(remittance_end_date).to_date,
          location_id: location_id.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
