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
end
[5,4,3].my_each do |x| p x end
