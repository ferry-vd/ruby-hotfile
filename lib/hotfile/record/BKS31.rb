class Hotfile::Record::BKS31 < Hotfile::Record::Record
  ## Coupon Tax Information Record
  # ! not tested, I hope this code works at all...

  def initialize(line)
    segment1, coupon_airport1, segment_airport1, tax_code1, tax_type1, tax_amount1, tax_currency1, tax_amount_a1,
        segment2, coupon_airport2, segment_airport2, tax_code2, tax_type2, tax_amount2, tax_currency2, tax_amount_a2,
        reserved, currency =
      line.scan(%r{
        (\d)
        ([A-Z ]{5})
        ([A-Z ]{6})
        ([A-Z0-9]{2})
        ([A-Z0-9 ]{3})
        (\d{10}.)
        ([A-Z0-9 ]{4})
        ([\d ]{10}.)
        (\d)
        ([A-Z ]{5})
        ([A-Z ]{6})
        ([A-Z0-9]{2})
        ([A-Z0-9 ]{3})
        (\d{10}.)
        ([A-Z0-9 ]{4})
        ([\d ]{10}.)
        (.{6})
        ([A-Z0-9]{4})
      }x).flatten

    @data = {
      currency: currency.strip,
      coupons: [
        {
          segment: segment1.strip,
          segment_airport: segment_airport1.strip,
          coupon_tax: {
            currency: tax_currency1.strip,
            airport: coupon_airport1.strip,
            code: tax_code1.strip,
            type: tax_type1.strip,
            amount: Hotfile::Integer.new(tax_amount1).to_i,
            applicable_amount: Hotfile::Integer.new(tax_amount_a1).to_i,
          }
        },
        {
          segment: segment2.strip,
          segment_airport: segment_airport2.strip,
          coupon_tax: {
            currency: tax_currency2.strip,
            airport: coupon_airport2.strip,
            code: tax_code2.strip,
            type: tax_type2.strip,
            amount: Hotfile::Integer.new(tax_amount2).to_i,
            applicable_amount: Hotfile::Integer.new(tax_amount_a2).to_i,
          }
        }
      ].reject { |x| x[:segment] == '' },
      reserved: reserved.strip
    }
  end
end
