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

  def my_count(_element = nil, &proc)
    counter = 0
    my_each do |element|
      if block_given?
        counter += 1 if proc.call(element)
      elsif !el.nil?
        counter += 1 if element == arg
      else
        count == length
      end
    end
    counter
  end

  def my_map(proc = nil)
    if block_given?
      map = []
      my_each { |element| mapped << proc.call(element) }
    elsif proc.nil?
      my_each { |element| mapped << yield(element) }
    else
      enum_for(:map)
    end
    map
  end

  def my_inject(elmt = nil)
    return nil unless block_given?

    res = if !elmt.nil?
            elmt
          else
            self[0]
          end
    self[0..-1].my_each { |i| res = yield(res, i) }
    res
  end

  def multiply_els(arr)
    arr.my_inject { |x, y| x * y }
  end
end

array = [5, 4, 3, 2]
puts 'my_each'
array.my_each { |x| p x }
print "\n"
puts 'my_each_with_index'
array.my_each_with_index do |elem, index|
  p "#{elem} => #{index}"
end
puts '--------------'
puts 'my_select'

array.my_select do |x|
  p x if x.even?
end
puts '--------------'
puts 'my_all'

array.my_all? { |num| num > 6 }
puts '--------------'
puts 'my_any'

array.my_any? { |num| num > 6 }
puts '--------------'
puts 'none'

array.my_none? {}
puts '--------------'
puts 'my_count'

puts array.my_count(&:even?)
puts '--------------'
puts 'my_map'

puts array.map(&:to_i)
puts '--------------'
puts 'my_inject'
puts array.my_inject(3) { |num1, num2| num1 + num2 }