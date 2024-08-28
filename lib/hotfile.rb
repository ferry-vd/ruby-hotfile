# frozen_string_literal: true

## Main class
class Hotfile
  require 'hotfile/date'
  require 'hotfile/integer'
  require 'hotfile/string'

  require 'hotfile/parser'
  require 'hotfile/record'

  include Hotfile::Parser

  LINE_LENGTH = 136

  def initialize(file = nil)
    @file = if file.respond_to? :read
              file.read
            elsif file
              File.read file
            end
    @file = @file.delete("\r") if @file
  end

  def size
    @file&.size
  end
  alias length size
  alias count size

  def records
    @file&.lines(chomp: true)&.count
  end
  alias lines records
end
