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
	 def my_select
			select_in = Array.new
			self.my_each do 
				|counter| select_in << yield(counter) 
			end
			select_in
	end
	def my_all?
		self.my_each do |element|
			if block_given?
				val = yield (element)
			elsif element.nil? or !element or !val
				false
			else
				true
			end
		end
	end
	def my_any?

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

array.my_select do |x| 
	if x % 2 == 0
		p x
	end
end 
array.my_all? do |num| num > 6 end