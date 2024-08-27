class Hotfile::Record::BAR65 < Hotfile::Record::Record
  ## Additional Information–Passenger Record

  def initialize(line)
    name, passenger_data, date_of_birth, type, reserved =
      line.scan(%r{
        (.{49})
        (.{29})
        ([A-Z0-9 ]{7})
        ([A-Z0-9 ]{3})
        (.{8})
      }x).flatten

    @data = {
      name: name.strip,
      passenger_data: passenger_data.strip,
      date_of_birth: Hotfile::Date.new(date_of_birth).to_date,
      type: type.strip,
      reserved: reserved.strip
    }
  end
end
