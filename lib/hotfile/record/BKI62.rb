# frozen_string_literal: true

class Hotfile
  class Record
    ## Unticketed Point Information Record
    class BKI62 < Record
      def initialize(line)
        super

        segment, departure_airport, departure_date, departure_time, departure_terminal, arrival_airport, arrival_date,
          arrival_time, arrival_terminal, reserved =
          line.scan(/
            (\d)
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{7})
            ([\d ]{5})
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{5})
            ([A-Z0-9 ]{7})
            ([\d ]{5})
            ([A-Z0-9 ]{5})
            (.{51})
          /x).flatten

        @data = {
          segment: segment.to_i,
          departure: {
            airport: departure_airport.strip,
            datetime:
              DateTime.parse("#{Hotfile::Date.new(departure_date).to_date} #{departure_time.strip.insert(2, ':')}"),
            terminal: departure_terminal.strip
          },
          arrival: {
            airport: arrival_airport.strip,
            datetime:
              DateTime.parse("#{Hotfile::Date.new(arrival_date).to_date} #{arrival_time.strip.insert(2, ':')}"),
            terminal: arrival_terminal.strip
          },
          reserved: reserved.strip
        }
      end
    end
  end
end
