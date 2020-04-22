module Enumerable
	def my_each
		if block_given?
			for counter in self
				yield(counter)
			end
		else
			to_enum(:my_each)
		end
	end
	def my_each_with_index
		if block_given?
		   for counter in 0...size 
			  yield self[counter] ,counter
		   end
		else
		   to_enum(:my_each_with_index)
		end
	 end
end
array = [5,4,3,2]
puts "my_each"
array.my_each do |x| p x end
print "\n"
puts "my_each_with_index"
array.my_each_with_index do 
	|elem,index| 
	p "#{elem} => #{index}"
end
