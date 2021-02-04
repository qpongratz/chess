# frozen_string_literal: true

require_relative '../lib/pieces/pawn'
require 'pieces/piece'
require 'board'

describe Pawn do
  subject(:white_pawn) { described_class.new('white', 54) }
  subject(:black_pawn) { described_class.new('black', 1) }
  let(:board) { instance_double(Board) }
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
  describe '#position=' do
    context 'Pawn has not moved' do
      it 'Moved is false' do
        moved = white_pawn.moved
        expect(moved).to be false
      end
    end
    context 'Pawn moves forward one' do
      before do
        white_pawn.position = (46)
      end
      it 'En_passant is nil' do
        en_passant_position = white_pawn.en_passant_position
        expect(en_passant_position).to be nil
      end
      it 'Position is new position' do
        position = white_pawn.position
        expect(position).to eq([6, 5])
      end
      it 'Moved is true' do
        moved = white_pawn.moved
        expect(moved).to be true
      end
    end
    context 'Pawn moves forward two' do
      before do
        white_pawn.position = (38)
      end
      it 'En_passant is position passed over' do
        en_passant_position = white_pawn.en_passant_position
        expect(en_passant_position).to eq(46)
      end
    end
  end
  describe '#see?' do
    before do
      allow(board).to receive(:colors_match?).and_return(false)
      allow(board).to receive(:en_passant_position).and_return(nil)
    end
    context 'No pieces in front of pawn' do
      before do
        allow(board).to receive(:state).and_return([nil])
      end
      it 'Returns true for single move' do
        args = { board: board, destination: 9 }
        result = black_pawn.see?(args)
        expect(result).to be true
      end
      it 'Returns true for a double move forward' do
        args = { board: board, destination: 17 }
        result = black_pawn.see?(args)
        expect(result).to be true
      end
    end
    context 'Piece blocks position pawn wants to move to' do
      before do
        fake_state = Array.new(64)
        fake_state[9] = white_pawn
        fake_state[17] = white_pawn
        allow(board).to receive(:state).and_return(fake_state)
      end
      it 'Returns false for single move' do
        args = { board: board, destination: 9 }
        result = black_pawn.see?(args)
        expect(result).to be false
      end
      it 'Returns false for a double move forward' do
        args = { board: board, destination: 17 }
        result = black_pawn.see?(args)
        expect(result).to be false
      end
    end
  end
end