# frozen_string_literal: true

require_relative '../lib/pieces/pawn'
require 'pieces/piece'
require 'board'

describe Pawn do
  subject(:white_pawn) { described_class.new('white', 0) }
  subject(:black_pawn) { described_class.new('black', 1) }
  describe '#post_initialize' do
    context 'Pawn is white' do
      it 'Forward is set to -1' do
        forward = white_pawn.forward
        expect(forward).to eq(-1)
      end
      it 'Enemy color is set to black' do
        enemy_color = white_pawn.enemy_color
        expect(enemy_color).to eq('black')
      end
    end
    context 'Pawn is black' do
      it 'Forward is set to 1' do
        forward = black_pawn.forward
        expect(forward).to eq(1)
      end
      it 'Enemy color is set to black' do
        enemy_color = black_pawn.enemy_color
        expect(enemy_color).to eq('white')
      end
    end
  end
end