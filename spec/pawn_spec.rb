# frozen_string_literal: true

require_relative '../lib/pieces/pawn'
require 'pieces/piece'
require 'board'

# rubocop:disable Metrics/BlockLength

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
    context 'Forward pawn movement' do
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
    context 'Diagonal pawn movement' do
      context 'No pieces or en_passant in diagonals' do
        before do
          allow(board).to receive(:colors_match?).and_return(false)
          allow(board).to receive(:en_passant_position).and_return(nil)
          allow(board).to receive(:state).and_return([nil])
        end
        it 'Returns false for empty diagonal left square' do
          args = { board: board, destination: 8 }
          result = black_pawn.see?(args)
          expect(result).to be false
        end
        it 'Returns false for empty diagonal right square' do
          args = { board: board, destination: 10 }
          result = black_pawn.see?(args)
          expect(result).to be false
        end
      end
      context 'Enemy pieces in diagonals' do
        before do
          fake_state = Array.new(64)
          fake_state[8] = white_pawn
          fake_state[10] = white_pawn
          allow(board).to receive(:state).and_return(fake_state)
          allow(board).to receive(:colors_match?).and_return(true)
          allow(board).to receive(:en_passant_position).and_return(nil)
        end
        it 'Returns true for left diagonal' do
          args = { board: board, destination: 8 }
          result = black_pawn.see?(args)
          expect(result).to be true
        end
        it 'Returns true for right diagonal' do
          args = { board: board, destination: 10 }
          result = black_pawn.see?(args)
          expect(result).to be true
        end
      end
      context 'En_passant for diagonal spaces' do
        before do
          allow(board).to receive(:colors_match?).and_return(false)
          allow(board).to receive(:en_passant_position).and_return(8, 10)
          allow(board).to receive(:state).and_return([nil])
        end
        it 'Returns true for left diagonal' do
          args = { board: board, destination: 8 }
          result = black_pawn.see?(args)
          expect(result).to be true
        end
        it 'Returns true for right diagonal' do
          args = { board: board, destination: 10 }
          result = black_pawn.see?(args)
          expect(result).to be true
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
