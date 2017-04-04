require 'csv'
require 'date'
require 'time'
class ItemisedBilling

	def itemised_bill
		csv = CSV.new(File.read('./ItemisedBill.csv'), headers: true)
		csv.to_a.map(&:to_h)
	end

	def phone_calls_for_provider provider
		item_list = itemised_bill()

		item_list.map do |x| 
			if x['Provider'] == provider
				x['Number']
			end
		end.compact
	end

	def provider_number_of_calls provider
		phone_calls_for_provider(provider)	
	end

	def convert_call_duration_to_seconds
		item_list = itemised_bill()

		result = Hash.new { |h, k| h[k] = [] }.tap do |h|       
			item_list.each do |item|
				h[item['Number']] << Time.parse("1 Jan 1970 #{item['Duration']} UTC").to_i     
			end
		end
	end
end



