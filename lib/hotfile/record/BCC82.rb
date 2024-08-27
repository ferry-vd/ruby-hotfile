class Hotfile::Record::BCC82 < Hotfile::Record::Record
  ## Additional Card Information Record
  # ! not tested, I hope this code works at all...

  def initialize(line)
    date_of_issue, transaction_number, payment_type, transaction_id, reserved =
      line.scan(%r{
        (\d{6})
        (\d{6})
        (.{10})
        (.{25})
        (.{76})
      }x).flatten

    @data = {
      date_of_issue: Hotfile::Date.new(date_of_issue).to_date,
      transaction_number: transaction_number.to_i,
      transaction_id: transaction_id.strip,
      payment_type: payment_type.strip,
      reserved: reserved.strip
    }
  end
end
