class Hotfile::Record::BAR67 < Hotfile::Record::Record
  ## Additional Information–Taxes
  # ! not tested, I hope this code works at all...

  def initialize(line)
    sequence_number, info_id, additional_info, reserved =
      line.scan(%r{
        (\d{2})
        (.{4})
        (.{70})
        (.{20})
      }x).flatten

    @data = {
      sequence_number: sequence_number.to_i,
      info_id: info_id.strip,
      additional_info: additional_info.strip,
      reserved: reserved.strip
    }
  end
end
