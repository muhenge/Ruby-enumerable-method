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
		my_each do 
			|element|
			if block_given?
				yield(element)
			elsif element.nil? or !i or !yield(element)
				false
			end
		end
		true
	end
	def my_any?
		my_each do 
			|element|
			if block_given?
				yield element
			elsif element.nil? or element or yield(element)
				true
			end
		end
		false
	end
	def my_none?
		if block_given?
		   p "true"
		end
		my_each do 
			|element| 
			if yield element
				p "false"
			end
		end

	end

	def my_account
		
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
array.my_any? do |num| num > 6 end
array.my_none? do end