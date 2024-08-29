# frozen_string_literal: true

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
    assert_equal(-4, Hotfile::Integer.new('000M').to_i)
    assert_equal 10, Hotfile::Integer.new('001{').to_i
    assert_equal 0, Hotfile::Integer.new('00000}').to_i
    assert_equal 25, Hotfile::Integer.new('00002E').to_i
  end

  def test_string
    assert_equal 'test', Hotfile::String.new('test  ').to_s
    assert_equal 1234, Hotfile::String.new('1234  ').to_i
  end

  def test_parsers
    # rubocop:disable Layout/LineLength
    hotfile = Hotfile.new

    # BFH01
    data = hotfile.parse_line('BFH0000000101AMSAGE230PROD2408200922NL000001                                                                                            ')
    assert_equal 'AMS', data[:data][:bsp_id]

    # BCH02
    data = hotfile.parse_line('BCH00000002020831240807F240807                                                                                                          ')
    assert_equal 1, data[:data][:cycle]

    # BOH03
    data = hotfile.parse_line('BOH000000030357231064240807EUR2                                                                                                         ')
    assert_equal 57_231_064, data[:data][:agent_code]

    # BKT06
    data = hotfile.parse_line('BKT0000000406000001  016390                                     FLGX                                                                    ')
    assert_equal 'FLGX', data[:data][:system_id]

    # BKS24
    data = hotfile.parse_line('BKS00000005242408060000013905822054200 3FFVV   57231064                TKTTBRUBRU    QH7TWU/F1    1439                                  ')
    assert_equal 'TKTT', data[:data][:transaction_code]
    assert_equal 'BKS24', data[:code][:id]
    assert_equal 5, data[:line_number]
    assert_equal Date.new(2024, 8, 6), data[:date]
    assert_equal 1, data[:transaction]
    assert_equal '3905822054200', data[:doc_nr]
    assert_equal 3, data[:check_digit]

    # BKS30
    data = hotfile.parse_line('BKS00000006302408060000013905822054200 30000002370{0000000000{YQ      0000000030{YQ      0000000030{BE      0000000353H0000003024E  EUR2')
    assert_equal 30_245, data[:data][:amounts][:total]

    # BKS39
    data = hotfile.parse_line('BKS00000009392408060000013905822054200 3I        000000000000000{      000000000000000{000000000000000{0000000000{I                 EUR2')
    assert_equal 'I', data[:data][:stat_code]

    # BKS46
    data = hotfile.parse_line('BKS00000010462408060000013905822054200 3                        00000000VALID ON A3 FLIGHTS ONLY                                        ')
    assert_equal 'VALID ON A3 FLIGHTS ONLY', data[:data][:endorsements_restrictions]

    # BKI62
    data = hotfile.parse_line('BKI00000011622408060000013905822054200 31BRU  24SEP241435      SKG  24SEP241815                                                         ')
    assert_equal 'BRU', data[:data][:departure][:airport]

    # BKI63
    data = hotfile.parse_line('BKI00000013632408060000013905822054200 31O24SEP24SEPBRU  SKG  A3  539  U 24SEP241435 OK1PCUHCMFLD                            ADT 320    ')
    assert_equal 'OK', data[:data][:booking][:status]

    # BAR64
    data = hotfile.parse_line('BAR00000015642408060000013905822054200 3EUR   237.00/            EUR   302.4594134XMLPEAT4                                              ')
    assert_equal 'XMLPEA', data[:data][:booking_agent]

    # BAR65
    data = hotfile.parse_line('BAR00000016652408060000013905822054200 3SURNAME/GIVENNAMEMS                                                           21MAY82ADT        ')
    assert_equal 'ADT', data[:data][:type]

    # BAR66
    data = hotfile.parse_line('BAR00000017662408060000013905822054200 31CASH                                                                                           ')
    assert_equal 'CASH', data[:data][:payment_information]

    # BKF81
    data = hotfile.parse_line('BKF00000018812408060000013905822054200 31BRU A3 SKG110.26UHCMFLD A3 BRU145.93SHCMFLD NUC256.19END ROE0.925058                           ')
    assert_equal 1, data[:data][:sequence_number]

    # BKP84
    data = hotfile.parse_line('BKP0000001984240806000001CA        0000003024E                                             0000000000003024E                        EUR2')
    assert_equal 'CA', data[:data][:payment_type]

    # BOT93
    data = hotfile.parse_line('BOT00000036935723106424080700000000006049{00000000006049{00000000000000}00000000001309{TKTT00000000000000{                          EUR2')
    assert_equal 'TKTT', data[:data][:transaction_code]

    # BOT94
    data = hotfile.parse_line('BOT00000037945723106424080700000000006049{00000000006049{00000000000000}00000000001309{00000000000000{                              EUR2')
    assert_equal 57_231_064, data[:data][:agent_code]

    # BCT95
    data = hotfile.parse_line('BCT000000389508310000100000000006049{00000000006049{00000000000000{00000000001309{00000000000000{                                   EUR2')
    assert_equal 1, data[:data][:processing][:cycle]

    # BFT99
    data = hotfile.parse_line('BFT0000003999AMS0000100000000006049{00000000006049{00000000000000}00000000001309{00000000000000{                                    EUR2')
    assert_equal 'AMS', data[:data][:bsp_id]

    # rubocop:enable Layout/LineLength
  end
end
