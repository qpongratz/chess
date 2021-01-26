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
  end
end
