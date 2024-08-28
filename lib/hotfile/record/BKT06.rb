# frozen_string_literal: true

class Hotfile
  class Record
    ## Transaction Header Record
    class BKT06 < Record
      def initialize(line)
        super

        transaction, net_report, record, airline_code, agreement_ref, file_ref, system_id, auth_code, status,
            net_report_method, net_report_calc_type, are_indicator, reserved =
          line.scan(/
            (\d{6})
            ([A-Z0-9 ]{2})
            (\d{3})
            ([A-Z0-9]{3})
            ([A-Z0-9 ]{10})
            ([A-Z0-9 ]{27})
            ([A-Z0-9]{4})
            ([A-Z0-9 ]{14})
            ([A-Z0-9 ])
            ([A-Z0-9 ])
            ([A-Z0-9 ])
            ([A-Z0-9 ])
            (.{50})
          /x).flatten

        @data = {
          transaction: transaction.to_i,
          net_reporting: {
            indicator: net_report.strip,
            method: net_report_method.strip,
            calc_type: net_report_calc_type.strip
          },
          record: record.to_i,
          airline_code: airline_code,
          agreement_ref: agreement_ref.strip,
          file_ref: file_ref.strip,
          system_id: system_id,
          auth_code: auth_code.strip,
          input_status: status.strip,
          are_indicator: are_indicator.strip,
          reserved: reserved.strip
        }
      end
    end
  end
end
