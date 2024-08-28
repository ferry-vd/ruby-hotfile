# frozen_string_literal: true

class Hotfile
  class Record
    ## Office Totals per Currency Type Record
    class BOT94 < Record
      def initialize(line)
        super

        agent_code, remittance_end_date, gross, remittance, commission, tax, commission_tax, reserved, currency =
          line.scan(/
            (\d{8})
            (\d{6})
            (\d{14}.)
            (\d{14}.)
            (\d{14}.)
            (\d{14}.)
            (\d{14}.)
            (.{30})
            ([A-Z0-9]{4})
          /x).flatten

        @data = {
          currency: currency.strip,
          agent_code: agent_code.to_i,
          remittance_end_date: Hotfile::Date.new(remittance_end_date).to_date,
          gross: Hotfile::Integer.new(gross).to_i,
          remittance: Hotfile::Integer.new(remittance).to_i,
          commission: Hotfile::Integer.new(commission).to_i,
          tax: Hotfile::Integer.new(tax).to_i,
          commission_tax: Hotfile::Integer.new(commission_tax).to_i,
          reserved: reserved.strip
        }
      end
    end
  end
end
