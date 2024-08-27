class Hotfile::Record::BKS30 < Hotfile::Record::Record
  ## STD/Document Amounts Record

  def initialize(line)
    commissionable, net_fare, misc1_type, misc1_amount, misc2_type, misc2_amount, misc3_type, misc3_amount, amount,
        reserved, currency =
      line.scan(%r{
        (\d{10}.)
        ([\d ]{10}.)
        ([A-Z0-9 ]{8})
        ([\d ]{10}.)
        ([A-Z0-9 ]{8})
        ([\d ]{10}.)
        ([A-Z0-9 ]{8})
        ([\d ]{10}.)
        (\d{10}.)
        (.{2})
        ([A-Z0-9]{4})
      }x).flatten

    @data = {
      currency: currency.strip,
      amounts: {
        total: Hotfile::Integer.new(amount).to_i,
        net: Hotfile::Integer.new(net_fare).to_i,
        commissionable: Hotfile::Integer.new(commissionable).to_i,
        tax_misc: [
          { type: misc1_type.strip, amount: Hotfile::Integer.new(misc1_amount).to_i },
          { type: misc2_type.strip, amount: Hotfile::Integer.new(misc2_amount).to_i },
          { type: misc3_type.strip, amount: Hotfile::Integer.new(misc3_amount).to_i }
        ].reject { |x| x[:type] == '' }
      },
      reserved: reserved.strip
    }
  end
end
