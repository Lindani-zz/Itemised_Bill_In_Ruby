require "test/unit"
require "./itemised_bill"

class TestItemisedBilling < Test::Unit::TestCase

  def test_methods_exist
   
    itemised_bill = ItemisedBilling.new
    expected_methods = %w{ itemised_bill phone_calls_for_provider	}

    expected_methods.each do |method|
      assert(itemised_bill.respond_to?(method), "#{method} does not exist")
    end
  end

  def test_number_of_rows_returned
		 itemised_bill = ItemisedBilling.new
		 assert_equal itemised_bill.itemised_bill('./ItemisedBill.csv').size, 35
     assert_equal itemised_bill.itemised_bill('./ItemisedBill2.csv').size, 107  	
  end

  def test_phone_calls_for_provider
  	itemised_bill = ItemisedBilling.new
  	assert_equal itemised_bill.phone_calls_for_provider('MTN')[0], "0832401145"
  	assert_equal itemised_bill.phone_calls_for_provider('Vodacom')[0], "0821302398"
  	assert_equal itemised_bill.phone_calls_for_provider('CellC')[0], "0841257809"
  end

  def test_provider_number_of_calls
  	itemised_bill = ItemisedBilling.new
  	assert_equal itemised_bill.provider_number_of_calls('MTN').size, 16
  	assert_equal itemised_bill.provider_number_of_calls('Vodacom').size, 8
  	assert_equal itemised_bill.provider_number_of_calls('CellC').size, 11
  end

  def test_convert_call_duration_to_seconds
  	itemised_bill = ItemisedBilling.new
  	assert_equal itemised_bill.convert_call_duration_to_seconds[0], ["0832401145", 334]
  end
end