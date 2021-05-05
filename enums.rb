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
end

numbers = [1, 2, 3, 4, 5, 6, 7, 8]
numbers.my_select{|number| puts number if number % 2 == 0}
