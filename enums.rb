# rubocop:disable Style/For
# rubocop:disable Style/RedundantSelf
# rubocop:disable Style/CaseEquality
# rubocop:disable Metrics/ModuleLength

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

  def my_all?(*arg)
    my_all = true
    if !arg[0].nil?
      my_each do |item|
        my_all = false unless arg[0] === item
      end

    elsif !block_given?
      my_all = true
      my_each do |item|
        my_all = false unless item
      end
    else
      my_all = true
      my_each do |item|
        my_all = false unless yield(item)
      end
    end
    my_all
  end

  def my_any?(*params)
    result = false
    if !params[0].nil?
      my_each do |item|
        result = true if params[0] === item
      end
    elsif !block_given?
      my_each do |item|
        result = true if item
      end
    else
      to_a.my_each do |item|
        result = true if yield item
      end
    end
    result
  end

  def my_none?(*arg)
    my_none = true
    if !arg[0].nil?
      my_each do |item|
        my_none = false if arg[0] === item
      end

    elsif !block_given?
      my_none = true
      my_each do |item|
        my_none = false if item
      end

    else
      my_none = true
      my_each do |item|
        my_none = false if yield(item)
      end
    end
    my_none
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
# rubocop:enable Metrics/ModuleLength

def multiply_els
  self.my_inject { |result, element| result * element }
end

# rubocop:enable Style/RedundantSelf
# rubocop:enable Style/CaseEquality
