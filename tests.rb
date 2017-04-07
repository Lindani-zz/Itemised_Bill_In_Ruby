require "test/unit"
require "./itemised_bill"

class TestItemisedBilling < Test::Unit::TestCase

  def setup
    @itemised_bill = ItemisedBilling.new('./ItemisedBill.csv')
  end

  def test_number_of_calls_returned
    assert_equal @itemised_bill.total_phone_calls.size, 35      
		assert_not_equal @itemised_bill.total_phone_calls.size, nil     	
  end

  def test_phone_calls_for_provider
    assert_equal @itemised_bill.phone_calls_for_provider('MTN')[2], "0832401145"
    assert_equal @itemised_bill.phone_calls_for_provider('Vodacom')[0], "0821302398"
  	assert_equal @itemised_bill.phone_calls_for_provider('CellC')[0], "0841257809"
  end

  def test_provider_number_of_calls
    assert_equal @itemised_bill.provider_number_of_calls('MTN').size, 16
  	assert_equal @itemised_bill.provider_number_of_calls('Vodacom').size, 8
  	assert_equal @itemised_bill.provider_number_of_calls('CellC').size, 11
  end

  def test_convert_call_duration_to_seconds
  	assert_not_equal @itemised_bill.convert_call_duration_to_seconds[0], ["08324 01145", 334]
    assert_equal @itemised_bill.convert_call_duration_to_seconds[1], ["0838758090", 94]
  end

  def test_order_calls_by_ascending_duration
    assert_equal @itemised_bill.order_calls_by_ascending_duration[0..3], [["0828907600", 0], ["0828009712", 0], ["0821302398", 34], ["0824501276", 34]]
  end
end