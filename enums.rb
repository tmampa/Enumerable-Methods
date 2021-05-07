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
      self.my_each do |a|
        if yield(a)==false || yield(a).nil?
        return false
        end
      end
      true
    else
      self.my_all? do |b|
      b != false && b.nil? != true
      end
    end
  end

  def my_count
    if block_given?
    counter = 0
    self.my_each do |a|
      counter += 1 if yield(a)
    end
    else
      counter = self.length
    end
    counter
  end

  def my_map
    return to_enum(:my_map) unless block_given?
    new_arr = []
    for i in 0...self.size
      new_arr << yield(self[i])
    end
    new_arr
  end

  def my_inject(accum = self[0])
    self.unshift(self[0]) unless accum == self[0]
    for i in 0...self.size
      accum = yield(accum, self[i])
    end
    accum
  end

  def multiply_els
    self.my_inject { |result, element| result * element }
  end
end
