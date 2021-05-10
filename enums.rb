# rubocop:disable Style/RedundantSelf
# rubocop:disable Style/CaseEquality
# rubocop:disable Metrics/ModuleLength

module Enumerable
  def my_each(&block)
    return to_enum(:my_each) unless block_given?

    to_a.each(&block)
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    (0...to_a.length).each do |i|
      yield(to_a[i], i)
    end
    self
  end

  def my_select
    return enum_for unless block_given?

    arr = []
    my_each do |i|
      arr.push(i) if yield i
    end
    arr
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
    my_any = false
    if !params[0].nil?
      my_each do |item|
        my_any = true if params[0] === item
      end
    elsif !block_given?
      my_each do |item|
        my_any = true if item
      end
    else
      to_a.my_each do |item|
        my_any = true if yield item
      end
    end
    my_any
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

  def my_count(*args)
    i = 0
    if block_given?
      my_each do |x|
        i += 1 if yield x
      end
    elsif args.empty?
      my_each do |_x|
        i += 1
      end
    else
      my_each do |x|
        i += 1 if x == args[0]
      end
    end
    i
  end

  # rubocop:disable Style/NumericPredicate
  # rubocop:disable Style/RedundantReturn

  def my_map(*procs)
    my_map = []
    if procs.count == 0
      self.my_each { |elem| my_map << yield(elem) }
    else
      proc = procs[0]
      self.my_each(&proc)
    end
    return my_map
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity

  def my_inject(num = nil, sym = nil)
    if sym.instance_of?(Symbol) || sym.instance_of?(String)
      my_inject = num
      my_each do |item|
        my_inject = my_inject.nil? ? item : my_inject.send(sym, item)
      end
      my_inject
    elsif num.instance_of?(Symbol) || num.instance_of?(String)
      my_inject = nil
      my_each do |item|
        my_inject = my_inject.nil? ? item : my_inject.send(num, item)
      end
      my_inject
    else
      my_inject = num
      my_each do |item|
        my_inject = my_inject.nil? ? item : yield(my_inject, item)
      end
    end
    my_inject
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end

# rubocop:enable Metrics/ModuleLength
# rubocop:enable Style/NumericPredicate
# rubocop:enable Style/RedundantReturn

def multiply_els(array)
  array.my_inject(1) { |index, result| result * index }
end

# rubocop:enable Style/RedundantSelf
# rubocop:enable Style/CaseEquality
