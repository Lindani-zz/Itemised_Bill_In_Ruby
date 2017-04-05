require 'csv'
require 'date'
require 'time'
class ItemisedBilling

	# Dir.glob('*.csv').each do|f|
 # 		@@csv_file_path = f
	# end
	@@csv_file_path = './ItemisedBill.csv'

	def itemised_bill csv_file_path
		if File.exist?(csv_file_path)
			csv = CSV.new(File.read(csv_file_path, :encoding => 'utf-8'), headers: true)
			csv.to_a.map(&:to_h)
		end
	end

	def phone_calls_for_provider provider
		item_list = itemised_bill(@@csv_file_path)
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
		item_list = itemised_bill(@@csv_file_path)       
		item_list.map do |item|
			dt = Time.parse("1 Jan 1970 #{item['Duration']} UTC")
			seconds = dt.hour * 3600 + dt.min * 60 + dt.sec
			[item['Number']] << seconds     
		end
	end

	def order_calls_by_ascending_duration
		call_duration_list = convert_call_duration_to_seconds
		call_duration_list.sort_by do |number, duration|
			duration 
		end
	end
end
