class Hotfile::Record::BKS47 < Hotfile::Record::Record
  ## Netting Values Record
  # ! not tested, I hope this code works at all...

  def initialize(line)
    type1, code1, amount1, type2, code2, amount2, type3, code3, amount3, type4, code4, amount4, reserved, currency =
      line.scan(%r{
        ([A-Z])
        ([A-Z0-9 ]{8})
        (\d{10}.)
        ([A-Z])
        ([A-Z0-9 ]{8})
        (\d{10}.)
        ([A-Z])
        ([A-Z0-9 ]{8})
        (\d{10}.)
        ([A-Z])
        ([A-Z0-9 ]{8})
        (\d{10}.)
        (.{12})
        ([A-Z0-9]{4})
      }x).flatten

    @data = {
      currency: currency.strip,
      netting_values: [
        { type: type1.strip, code: code1.strip, amount: Hotfile::Integer.new(amount1).to_i },
        { type: type2.strip, code: code2.strip, amount: Hotfile::Integer.new(amount2).to_i },
        { type: type3.strip, code: code3.strip, amount: Hotfile::Integer.new(amount3).to_i },
        { type: type4.strip, code: code4.strip, amount: Hotfile::Integer.new(amount4).to_i }
      ].reject { |x| x[:type] == ''},
      reserved: reserved.strip
    }
  end
end
