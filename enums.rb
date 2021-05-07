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
      self.my_each do |a|
        if yield(a) == false || yield(a).nil?
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
end

# rubocop:enable Style/For

def multiply_els
  self.my_inject { |result, element| result * element }
end

# rubocop:enable Style/RedundantSelf
