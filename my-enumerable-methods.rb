module Enumerable
	def my_each
		if block_given?
			for i in self
				yield(i)
			end
		else
			return to_enum(:my_each)
		end
	end	
end
