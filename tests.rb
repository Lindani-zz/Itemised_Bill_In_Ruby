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
		 assert_equal itemised_bill.itemised_bill.size, 35  	
  end

  def test_calls_for_specified_provider
  	itemised_bill = ItemisedBilling.new
  	assert_equal itemised_bill.phone_calls_for_provider('MTN')[0], "0832401145"
  	assert_equal itemised_bill.phone_calls_for_provider('Vodacom')[0], "0821302398"
  	assert_equal itemised_bill.phone_calls_for_provider('CellC')[0], "0841257809"
  end

  def test_number_of_calls_made_per_provider
  	itemised_bill = ItemisedBilling.new
  	assert_equal itemised_bill.provider_number_of_calls('MTN').size, 16
  	assert_equal itemised_bill.provider_number_of_calls('Vodacom').size, 8
  	assert_equal itemised_bill.provider_number_of_calls('CellC').size, 11
  end

  def test_duration_convertion_in_seconds
  	itemised_bill = ItemisedBilling.new
  	assert_equal itemised_bill.convert_call_duration_to_seconds["0841257809"], [154, 334, 184, 394, 184, 334, 394, 124]
  end
end