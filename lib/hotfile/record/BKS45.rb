class Hotfile::Record::BKS45 < Hotfile::Record::Record
  ## Related Ticket/Document Information Record
  # ! not tested, I hope this code works at all...

  def initialize(line)
    waiver, reason, identifier, date_of_issue, reserved =
      line.scan(%r{
        (.{14})
        (.{5})
        ([\d ]{4})
        ([\d ]{6})
        (.{67})
      }x).flatten

    @data = {
      waiver: waiver.strip,
      reason_code: reason.strip,
      identifier: identifier.strip,
      date_of_issue: Hotfile::Date.new(date_of_issue).to_date,
      reserved: reserved.strip
    }
  end
end
