class Hotfile::String
  def initialize(string)
    @raw_value = string
  end

  def to_s
    @raw_value.strip
  end

  def to_i
    Hotfile::Integer.new(@raw_value).to_i
  end
end