class Hotfile::Record::BKS42 < Hotfile::Record::Record
  ## Tax on Commission Record
  # ! not tested, I hope this code works at all...

  def initialize(line)
    type1, amount1, type2, amount2, type3, amount3, type4, amount4, reserved, currency =
      line.scan(%r{
        ([A-Z0-9 ]{6})
        ([\d ]{10}.)
        ([A-Z0-9 ]{6})
        ([\d ]{10}.)
        ([A-Z0-9 ]{6})
        ([\d ]{10}.)
        ([A-Z0-9 ]{6})
        ([\d ]{10}.)
        (.{24})
        ([A-Z0-9]{4})
      }x).flatten

    @data = {
      currency: currency.strip,
      taxes: [
        { type: type1.strip, amount: Hotfile::Integer.new(amount1).to_i },
        { type: type2.strip, amount: Hotfile::Integer.new(amount2).to_i },
        { type: type3.strip, amount: Hotfile::Integer.new(amount3).to_i },
        { type: type4.strip, amount: Hotfile::Integer.new(amount4).to_i }
      ].reject { |x| x[:type] == '' },
      reserved: reserved.strip
    }
  end
end
