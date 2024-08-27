class Hotfile::Record::BFT99 < Hotfile::Record::Record
  ## File Totals per Currency Type Record

  def initialize(line)
    bsp_id, office_count, gross, remittance, commission, tax, commission_tax, reserved, currency =
      line.scan(%r{
        ([A-Z0-9 ]{3})
        (\d{5})
        (\d{14}.)
        (\d{14}.)
        (\d{14}.)
        (\d{14}.)
        (\d{14}.)
        (.{36})
        ([A-Z0-9]{4})
      }x).flatten

    @data = {
      currency: currency.strip,
      bsp_id: bsp_id.strip,
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
