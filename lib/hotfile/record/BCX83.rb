class Hotfile::Record::BCC82 < Hotfile::Record::Record
  ## 3DS Authentication and Additional Card Payment Information Record
  # ! not tested, I hope this code works at all...

  def initialize(line)
    date_of_issue, transaction_number, payment_type, auth_sequence_nr, reserved =
      line.scan(%r{
        (\d{6})
        (\d{6})
        (.{10})
        (\d{2})
        (.{99})
      }x).flatten

    @data = {
      date_of_issue: Hotfile::Date.new(date_of_issue).to_date,
      transaction_number: transaction_number.to_i,
      auth_sequence_nr: auth_sequence_nr.strip,
      payment_type: payment_type.strip,
      reserved: reserved.strip
    }
  end
end
