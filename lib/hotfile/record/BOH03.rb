class Hotfile::Record::BOH03 < Hotfile::Record::Record
  ## (Reporting Agent) Office Header Record

  def initialize(line)
    agent_code, remittance_end_date, currency, location_id, reserved =
      line.scan(%r{
        (\d{8})
        (\d{6})
        ([A-Z0-9]{4})
        ([A-Z0-9 ]{3})
        (.{102})
      }x).flatten

    @data = {
      currency: currency.strip,
      agent_code: agent_code.to_i,
      remittance_end_date: Hotfile::Date.new(remittance_end_date).to_date,
      location_id: location_id.strip,
      reserved: reserved.strip
    }
  end
end
