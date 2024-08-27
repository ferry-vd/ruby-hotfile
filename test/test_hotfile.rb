require 'minitest/autorun'
require 'hotfile'

class HotfileTest < Minitest::Test
  def test_date
    assert_equal Date.new(Date.today.year, 4, 6), Hotfile::Date.new('06APR').to_date
    assert_equal Date.new(2001, 7, 9), Hotfile::Date.new('010709').to_date
    assert_equal Date.new(2011, 7, 8), Hotfile::Date.new('08JUL11').to_date
    assert_equal Date.new(2016, 7, 1), Hotfile::Date.new('20160701').to_date
  end

  def test_integer
    assert_equal true, Hotfile::Integer.new('000M').negative?
    assert_equal( -4, Hotfile::Integer.new('000M').to_i)
    assert_equal 10, Hotfile::Integer.new('001{').to_i
    assert_equal 0, Hotfile::Integer.new('00000}').to_i
    assert_equal 25, Hotfile::Integer.new('00002E').to_i
  end

  def test_string
    assert_equal 'test', Hotfile::String.new('test  ').to_s
    assert_equal 1234, Hotfile::String.new('1234  ').to_i
  end
end
