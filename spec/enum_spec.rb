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

