require './enums'

describe Enumerable do
  array = %w[Sharon Leo Leila Brian Arun]
  num_array = [10, 20, 30, 5, 7, 9, 3]
  hash = { min: 2, max: 5 }

  describe '#my_each' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_each).to be_an Enumerator
      end
    end

    context 'if block given' do
      context 'when self is an array' do
        it 'yields item' do
          arr = array.my_each { |friend| friend }
          expect(arr).to eq(%w[Sharon Leo Leila Brian Arun])
        end

        context 'when self is a hash' do
          it 'yields item' do
            result = []
            hash.my_each { |key, value| result.push("k: #{key}, v: #{value}") }
            expect(result).to eq(['k: min, v: 2', 'k: max, v: 5'])
          end
        end

        context 'when self is a range' do
          it 'yields items in that range' do
            arr = array[3..-1].my_each { |item| item }
            expect(arr).to eq(%w[Brian Arun])
          end
        end
      end
    end
  end

  describe '#my_each_with_index' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_each_with_index).to be_an Enumerator
      end
    end

    context 'if block given' do
      context 'when self is an array' do
        it 'yields index' do
          arr = []
          array.my_each_with_index { |_item, index| arr.push(index) }
          expect(arr).to eq([0, 1, 2, 3, 4])
        end
      end
      context 'when self is a hash' do
        it 'yields item with index' do
          arr = []
          array.my_each_with_index { |friend, index| arr.push("#{index}: #{friend}") if index.odd? }
          expect(arr).to eq(['1: Leo', '3: Brian'])
        end
      end
      context 'when self is a range' do
        it 'yields items in that range' do
          arr = []
          array[3..-1].my_each_with_index { |item, index| arr.push("#{index}: #{item}") }
          expect(arr).to eq(['0: Brian', '1: Arun'])
        end
      end
    end
  end

  describe '#my_select' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_select).to be_an Enumerator
      end
    end

    context 'if block given' do
      context 'when self is an array' do
        it 'yields selected items' do
          arr = []
          array.my_select { |friend| arr.push(friend) if friend != 'Brian' }
          expect(arr).to eq(%w[Sharon Leo Leila Arun])
        end
      end

      context 'when self is a hash' do
        it 'yields selected items with their index' do
          result = []
          hash.my_select { |k, v| result.push(k, v) if v > 4 }
          expect(result).to eq([:max, 5])
        end
      end

      context 'when self is a range' do
        it 'yields selected items within that range' do
          arr = []
          array[3..-1].my_select { |friend| arr.push(friend) if friend != 'Brian' }
          expect(arr).to eq(['Arun'])
        end
      end
    end
  end

  describe '#my_all?' do
    context 'if block given' do
      it "returns false if all the items doesn't yield true" do
        expect(%w[Sharon Leo Leila Brian Arun].my_all? { |word| word.length > 5 }).to be(false)
      end
    end
    context 'if block not given' do
      context 'if the argument is a class' do
        it "returns false if all the items doesn't satisfy a given condition" do
          expect(%w[Sharon Leo Leila Brian Arun].my_all?(Float)).to be(false)
        end
      end
      context 'if the argument is a Regex' do
        it "returns false if all the items doesn't satisfy a given condition" do
          expect(%w[Sharon Leo Leila Brian Arun].my_all?(/a/)).to be(false)
        end
      end
    end
  end

  describe '#my_any?' do
    context 'if block given' do
      it 'returns true if any of the item yields true' do
        expect(%w[Sharon Leo Leila Brian Arun].my_any? { |word| word.length > 5 }).to be(true)
      end
    end
    context 'if block not given' do
      context 'if the argument is a Regex' do
        it 'returns true if any of the item satisfies a given condition' do
          expect(%w[Sharon Leo Leila Brian Arun].my_any?(/a/)).to be(true)
        end
      end
      context 'if the argument is a class' do
        it 'returns true if any of the item satisfies a given condition' do
          expect(%w[Sharon Leo Leila Brian Arun].my_any?(String)).to be(true)
        end
      end
    end
  end

  describe '#my_none?' do
    context 'if block given' do
      it 'returns true if none of the items yield true' do
        expect(%w[Sharon Leo Leila Brian Arun].my_none? { |word| word.length > 6 }).to be(true)
      end
    end
    context 'if block not given' do
      context 'if the argument is a Regex' do
        it 'returns true if none of the items satisfy a given condition' do
          expect(%w[Sharon Leo Leila Brian Arun].my_none?(/c/)).to be(true)
        end
      end
      context 'if the argument is a Class' do
        it 'returns true if none of the items satisfy a given condition' do
          expect(%w[Sharon Leo Leila Brian Arun].my_none?(Numeric)).to be(true)
        end
      end
    end
  end

  describe '#my_count' do
    context 'if block given' do
      it 'returns number of items satisfying the condition' do
        expect(%w[Sharon Leo Leila Brian Arun].my_count { |word| word.length > 5 }).to eq(1)
      end
    end
    context 'if block and argument given' do
      it 'returns number of arguments satisfying the condition' do
        expect(%w[Sharon Leo Leila Brian Arun Leon Leone].my_count('Leo') { |word| word == 'Leo' }).to eq(1)
      end
    end
    context 'if block not given, but argument given' do
      it 'returns count of that particular argument' do
        expect(%w[Sharon Leo Leila Leo Brian Arun Leo].my_count('Leo')).to eq(3)
      end
    end
    context 'if block and argument both not given' do
      it 'returns size of the instance' do
        expect(%w[Sharon Leo Leila Brian Arun].my_count).to eq(5)
      end
    end
  end

  describe '#my_map' do
    context 'if block not given' do
      it 'returns enum' do
        expect(array.my_map).to be_an Enumerator
      end
    end

    context 'if block given' do
      it 'returns a new array applying the given operation to the items' do
        arr = array.my_map(&:upcase)
        expect(arr).to eq(%w[SHARON LEO LEILA BRIAN ARUN])
      end
    end
  end

  describe '#my_inject' do
    context 'if block given and arg given' do
      context 'for a number array with arg' do
        it 'returns numbers those passes our filter' do
          num = []
          num_array.my_inject([]) { |_result, element| num << element.to_s if element > 9 }
          expect(num).to eq(%w[10 20 30])
        end
      end
      context 'for a array of strings without arg' do
        it 'returns items those passes our filter' do
          longest = array.my_inject { |memo, word| memo.size > word.size ? memo : word }
          expect(longest).to eq('Sharon')
        end
      end
    end
    context 'if block not given, but argument given' do
      context 'plus symbol given' do
        it 'returns sum of items' do
          num = num_array.my_inject(:+)
          expect(num).to eq(84)
        end
      end
      context 'multiplication symbol given' do
        it 'returns multiplication of items' do
          num = num_array.my_inject(:*)
          expect(num).to eq(5_670_000)
        end
      end
    end
  end
end
