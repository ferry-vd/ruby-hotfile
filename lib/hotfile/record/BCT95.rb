# frozen_string_literal: true

class Hotfile
  class Record
    ## Billing Analysis (Cycle) Totals per Currency Type Record
    class BCT95 < Record
      def initialize(line)
        super

        processing_date_id, cycle_id, office_count, gross, remittance, commission, tax, commission_tax, reserved,
            currency =
          line.scan(/
            ([A-Z0-9 ]{3})
            (\d)
            (\d{5})
            (\d{14}.)
            (\d{14}.)
            (\d{14}.)
            (\d{14}.)
            (\d{14}.)
            (.{35})
            ([A-Z0-9]{4})
          /x).flatten

        @data = {
          currency: currency.strip,
          processing: { date: processing_date_id.strip, cycle: cycle_id.to_i },
          office_count: Hotfile::Integer.new(office_count).to_i,
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
