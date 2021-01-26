# frozen_string_literal: true

require 'conversions'

# Fake class to test conversion methods independently
class TestConversions
  include Conversions
end

describe Conversions do
  subject(:convert) { TestConversions.new }
  context 'From index to coordinates' do
    it 'Returns [7, 7]' do
      index = 63
      coordinates = convert.index_to_coordinates(index)
      expect(coordinates).to eq([7, 7])
    end
    it 'Returns [0, 0]' do
      index = 0
      coordinates = convert.index_to_coordinates(index)
      expect(coordinates).to eq([0, 0])
    end
    it 'Returns [4, 6]' do
      index = 52
      coordinates = convert.index_to_coordinates(index)
      expect(coordinates).to eq([4, 6])
    end
  end
  context 'From coordinates to index' do
    it 'Returns 63' do
      coordinates = [7, 7]
      index = convert.coordinates_to_index(coordinates)
      expect(index).to eq(63)
    end
    it 'Returns 0' do
      coordinates = [0, 0]
      index = convert.coordinates_to_index(coordinates)
      expect(index).to eq(0)
    end
    it 'Returns 52' do
      coordinates = [4, 6]
      index = convert.coordinates_to_index(coordinates)
      expect(index).to eq(52)
    end
  end
end
