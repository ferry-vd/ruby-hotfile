class Hotfile::Record::BKS39 < Hotfile::Record::Record
  ## Commission Record

  def initialize(line)
    stat_code, type, rate, amount, type2, rate2, amount2, effective_rate, effective_amount, paid, rdi_indicator,
        cca_indicator, reserved, currency =
      line.scan(%r{
        ([A-Z0-9 ]{3})
        ([A-Z0-9 ]{6})
        (\d{5})
        (\d{10}.)
        ([A-Z0-9 ]{6})
        ([\d ]{5})
        ([\d ]{10}.)
        (\d{5})
        (\d{10}.)
        ([\d ]{10}.)
        ([A-Z0-9 ])
        ([A-Z0-9 ])
        (.{16})
        ([A-Z0-9]{4})
      }x).flatten

    @data = {
      currency: currency.strip,
      stat_code: stat_code.strip,
      types: [type.strip, type2.strip].reject { |x| x == '' },
      rates: [Hotfile::Integer.new(rate).to_i, Hotfile::Integer.new(rate2).to_i].reject { |x| x == 0 },
      amounts: [Hotfile::Integer.new(amount).to_i, Hotfile::Integer.new(amount2).to_i].reject { |x| x == 0 },
      effective_rate: Hotfile::Integer.new(effective_rate).to_i,
      effective_amount: Hotfile::Integer.new(effective_amount).to_i,
      paid_amount: Hotfile::Integer.new(paid).to_i,
      rdi_indicator: rdi_indicator.strip,
      cca_indicator: cca_indicator.strip,
      reserved: reserved.strip
    }
  end
end
