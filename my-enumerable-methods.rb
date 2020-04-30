module Enumerable
  def my_each
    if block_given?
      each do |counter|
        yield(counter)
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      (0...size).each do |counter|
        yield self[counter], counter
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    select_in = []
    my_each do |counter|
      select_in << yield(counter)
    end
    select_in
  end

  def my_all?
    my_each do |element|
      if block_given?
        yield(element)
      elsif element.nil? or !i or !yield(element)
        puts false
      end
    end
    puts true
  end

  def my_any?
    my_each do |element|
      if block_given?
        yield element
      elsif element.nil? or element or yield(element)
        puts true
      end
    end
    puts false
  end

  def my_none?
    puts true if block_given?
    my_each do |element|
      puts false if yield element
    end
  end

  def my_count(el = nil, &proc)
    counter = 0
    my_each do |element|
      if block_given?
        counter += 1 if proc.call(element)
      elsif !el.nil?
        counter += 1 if element == argelse
        count = length
      end
    end
    counter
  end

  def my_map(proc = nil)
    if block_given?
      map = Array.new
      my_each do |element| mapped << proc.call(element) end
    elsif proc.nil?
      my_each do |element| mapped << yield(element) end
    else
      enum_for(:map)
    end
    map
  end

  def my_inject(el)
    if !block_given?
      return nil
    elsif !el.nil?
      res = el
      c = 0
    else
      res = self[0] 
      c = 1
    end
    [c..-1].my_each { |i| res = yield(res,index) }
    res
  end
end

array = [5, 4, 3, 2]
puts "my_each"
array.my_each { |x| p x }
print "\n"
puts "my_each_with_index"
array.my_each_with_index do |elem, index|
  p "#{elem} => #{index}"
end
puts "--------------"
puts "my_select"

array.my_select do |x|
  p x if x.even?
end
puts "--------------"
puts "my_all"

array.my_all? { |num| num > 6 }
puts "--------------"
puts "my_any"

array.my_any? { |num| num > 6 }
puts "--------------"
puts "none"

array.my_none? { }
puts "--------------"
puts "my_count"

puts array.my_count
puts "--------------"
puts "my_map"

puts array.map { |num| num * 2 }
puts "--------------"
puts "my_inject"
puts array.my_inject(0) { |num1,num2| num1+num2}