# rubocop:disable Style/For
# rubocop:disable Style/RedundantSelf

module Enumerable
  def my_each
    for item in self
      yield(item)
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

  def my_all?
    if block_given?
      my_each do |a|
        return false if yield(a) == false || yield(a).nil?
      end
      true
    else
      my_all? do |b|
        b != false && b.nil? != true
      end
    end
  end

  def my_any
    if block_given?
      my_each { |i| return true if yield(i) }
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |i| return false if yield(i) }
    else
      my_each { |i| return false if i }
    end
    true
  end

  def my_count
    if block_given?
      counter = 0
      my_each do |a|
        counter += 1 if yield(a)
      end
    else
      counter = length
    end
    counter
  end

  def my_map(arg = nil)
    arr = []
    i = 0
    if !arg.nil? && arg.respond_to?(:call)
      while i < length
        arr << arg.call(self[i])
        i += 1
      end
    elsif arg.nil? && block_given?
      while i < length
        arr << yield(self[i])
        i += 1
      end
    end
    arr
  end

  def my_inject(accum = self[0])
    unshift(self[0]) unless accum == self[0]
    (0...size).each do |i|
      accum = yield(accum, self[i])
    end
    accum
  end
end

# rubocop:enable Style/For

def multiply_els
  self.my_inject { |result, element| result * element }
end

# rubocop:enable Style/RedundantSelf
