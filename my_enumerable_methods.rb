module Enumerable
  def my_each
    counter = 0
    arr = Array.new(counter)
    if block_given?
      while counter < size
        yield(arr[counter] = to_a[counter])
        counter += 1
      end
      arr
    else
      to_enum(:each)
    end
  end

  def my_each_with_index
    if block_given?
      (0...size).my_each do |counter|
        yield self[counter], counter
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      select_in = []
      my_each do |counter|
        select_in << counter if yield(counter)
      end
      select_in
    else
      to_enum(:select)
    end
  end

  def my_all?(args = nil)
    element = true
    if args.nil?
      block_given? ? my_each { |x| element = false unless yield x } : element = my_all? { |x| !x.nil? && (x != false) }
    else
      my_each { |x| element = false unless args == x }
    end
    element
  end

  def my_any?(args = nil)
    val = false
    if args.nil?
      block_given? ? my_each { |x| val = true if yield x } : val = my_any? { |x| !x.nil? && (x != false) }
    else
      my_each { |x| val = true if args == x }
    end
    val
  end

  def my_none?(args = nil)
    val = true
    if args.nil?
      block_given? ? my_each { |x| val = false if yield x } : my_any? { |x| return false if x == true }
    else
      my_each { |x| val = false if args == x }
    end
    val
  end

  def my_count(item = nil)
    count = 0
    if item.nil?
      block_given? ? my_each { |x| count += 1 if yield x } : my_each { count += 1 }
    else
      my_each { |x| count += 1 if item == x }
    end
    count
  end

  def my_map
    return to_enum unless block_given?

    arr = []
    my_each { |x| arr << yield(x) }
    arr
  end

  def my_inject(val1 = nil, val2 = nil)
    first_element = true
    case val1
    when nil then val = to_a[0]
    when Numeric, Symbol
      val = val1
      first_element = false
    end
    if block_given?
      my_each { |x| first_element == true ? first_element = false : val = yield(val, x) }
    else
      val1, val2 = val2, val1 if val1.is_a? Symbol
      val = my_inject(val1) do |total, x|
        instance_eval "#{total} #{val2} #{x}", __FILE__, __LINE__
      end
    end
    val
  end
end

def multiply_els(arr)
  arr.inject { |product, n| product * n }
end
