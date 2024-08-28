# frozen_string_literal: true

class Hotfile
  class Record
    ## Document Amounts Record
    class BAR64 < Record
      def initialize(line)
        super

        fare, ti_indicator, equivalent_fare, total, system_id, fcm_indicator, booking_agent, outlet_type, fcp_indicator,
            issuing_agent, reserved =
          line.scan(/
            (.{12})
            (.)
            (.{12})
            (.{12})
            ([A-Z0-9 ]{4})
            ([A-Z0-9 ])
            ([A-Z0-9 ]{6})
            ([A-Z0-9 ])
            ([A-Z0-9 ])
            ([A-Z0-9 ]{8})
            (.{38})
          /x).flatten

        @data = {
          fare: fare.strip,
          equivalent_fare: equivalent_fare.strip,
          total_fare: total.strip,
          system_id: system_id.strip,
          booking_agent: booking_agent.strip,
          outlet_type: outlet_type.strip,
          issuing_agent: issuing_agent.strip,
          indicators: {
            ti: ti_indicator.strip,
            fcm: fcm_indicator.strip,
            fcp: fcp_indicator.strip
          },
          reserved: reserved.strip
        }
      end
    end
  end
end
