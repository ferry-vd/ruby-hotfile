class Hotfile::Record::BKF81 < Hotfile::Record::Record
  ## Fare Calculation Record

  def initialize(line)
    sequence_number, info, reserved =
      line.scan(%r{
        (\d)
        (.{87})
        (.{8})
      }x).flatten

    @data = {
      sequence_number: sequence_number.to_i,
      info: info.strip,
      reserved: reserved.strip
    }
  end
end
