# frozen_string_literal: true

class Hotfile
  class Record
    ## Billing Analysis (Cycle) Header Record
    class BCH02 < Record
      def initialize(line)
        super

        processing_date, cycle, billing_end_date, run_id, reporting_end_date, reserved =
          line.scan(/
            ([A-Z0-9]{3})
            (\d)
            (\d{6})
            ([A-Z0-9])
            (\d{6})
            (.{106})
          /x).flatten

        @data = {
          processing_date: processing_date,
          cycle: cycle.to_i,
          billing_end_date: Hotfile::Date.new(billing_end_date).to_date,
          run: run_id,
          reporting_end_date: Hotfile::Date.new(reporting_end_date).to_date,
          reserved: reserved.strip
        }
      end
    end
  end
end
