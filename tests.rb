require "test/unit"
require "./itemised_bill"

class TestItemisedBilling < Test::Unit::TestCase

  def setup
    @itemised_bill = ItemisedBilling.new
  end

  def test_methods_exist
    expected_methods = %w{ itemised_bill phone_calls_for_provider	}
    expected_methods.each do |method|
      assert(@itemised_bill.respond_to?(method), "#{method} does not exist")
    end
  end

  def test_itemised_bill_file_existence
    assert_equal @itemised_bill.itemised_bill('./ItemisedBil.csv'), nil
  end

  def test_number_of_rows_returned_for_first_itemised_bill
		assert_equal @itemised_bill.itemised_bill('./ItemisedBill.csv').size, 35
    assert_equal @itemised_bill.itemised_bill('./ItemisedBill2.csv').size, 52       
    assert_equal @itemised_bill.itemised_bill('./ItemisedBill3.csv').size, 0        
    assert_not_equal @itemised_bill.itemised_bill('./ItemisedBill3.csv').size, -1      	
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
    assert_equal @itemised_bill.convert_call_duration_to_seconds[0], ["0832401145", 334]
  	assert_not_equal @itemised_bill.convert_call_duration_to_seconds[0], ["08324 01145", 334]
    assert_equal @itemised_bill.convert_call_duration_to_seconds[1], ["0838758090", 94]
  end
end