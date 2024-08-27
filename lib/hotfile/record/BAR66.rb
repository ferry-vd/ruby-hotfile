class Hotfile::Record::BAR66 < Hotfile::Record::Record
  ## Additional Information–Form of Payment Record

  def initialize(line)
    sequence_number, payment_information, reserved =
      line.scan(%r{
        (\d)
        (.{50})
        (.{45})
      }x).flatten

    @data = {
      sequence_number: sequence_number.to_i,
      payment_information: payment_information.strip,
      reserved: reserved.strip
    }
  end
end
