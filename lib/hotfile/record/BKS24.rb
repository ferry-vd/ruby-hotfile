# frozen_string_literal: true

class Hotfile
  class Record
    ## Ticket/Document Identification Record
    class BKS24 < Record
      def initialize(line)
        super

        coupon, conjunction, agent_code, issuance_reason, tour, transaction_code, destination, pnr, time, turnaround,
          reserved =
          line.scan(/
            ([A-Z0-9 ]{4})
            ([A-Z0-9 ]{3})
            (\d{8})
            ([A-Z0-9 ])
            ([A-Z0-9 ]{15})
            ([A-Z0-9]{4})
            ([A-Z0-9 ]{10})
            (.{13})
            ([\d ]{4})
            ([A-Z0-9 ]{5})
            (.{29})
          /x).flatten
        time = nil if time.strip == ''

        @data = {
          transaction_code: transaction_code,
          time: time&.insert(2, ':'),
          coupon: coupon.strip,
          conjunction: conjunction.strip,
          agent_code: agent_code.to_i,
          issuance_reason: issuance_reason.strip,
          tour: tour.strip,
          destination: destination.strip,
          pnr: pnr.strip,
          turnaround: turnaround.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
