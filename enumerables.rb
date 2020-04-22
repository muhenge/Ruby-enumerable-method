module Enumerable
	def my_each
		if block_given?
			arr_counter = 0
			arr = Array.new
			while arr_counter < arr.length
				yield arr[arr_counter]
				arr_counter += 1
			end
		else
			return to_enum(:my_each)
		end
	end	
	
end


