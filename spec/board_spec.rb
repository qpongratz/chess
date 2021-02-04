# frozen_string_literal: true

require 'board'
require 'player'

# rubocop:disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }
  let(:white_piece) { instance_double(Piece) }
  let(:black_piece) { instance_double(Piece) }

  describe '#valid_move?' do
    before do
      allow(white_piece).to receive(:color).and_return('white')
      allow(black_piece).to receive(:color).and_return('black')
    end
    context 'Start position is empty' do
      it 'Returns false' do
        allow(board).to receive(:state).and_return([nil])
        result = board.valid_move?(0, 1, 'white')
        expect(result).to be false
      end
    end
    context 'Start position piece is not same color as player' do
      it 'Returns false' do
        allow(board).to receive(:state).and_return([black_piece, white_piece])
        result = board.valid_move?(0, 1, 'white')
        expect(result).to be false
      end
    end
    context 'Destination is same color as player' do
      it 'Returns false' do
        allow(board).to receive(:state).and_return([white_piece, white_piece])
        result = board.valid_move?(0, 1, 'white')
        expect(result).to be false
      end
    end
    context 'Destination is unreachable by piece' do
      it 'Returns false' do
        allow(board).to receive(:state).and_return([white_piece, nil])
        allow(white_piece).to receive(:see?).and_return(false)
        result = board.valid_move?(0, 1, 'white')
        expect(result).to be false
      end
    end
    context 'Path to Destination is blocked by another piece' do
      it 'Returns false' do
        allow(board).to receive(:state).and_return([white_piece, white_piece, nil])
        allow(white_piece).to receive(:see?).and_return(true)
        allow(white_piece).to receive(:path_to).and_return([1])
        result = board.valid_move?(0, 2, 'white')
        expect(result).to be false
      end
    end
    context 'Move will put player making move in check' do
      xit 'Returns false' do
        allow(board).to receive(:state).and_return([white_piece, nil, nil])
        allow(white_piece).to receive(:see?).and_return(true)
        allow(white_piece).to receive(:path_to).and_return([1])
        # setup stub for check to return false
        result = board.valid_move?(0, 2, 'white')
        expect(result).to be false
      end
    end
    context 'All checks pass' do
      it 'Returns true' do
        allow(board).to receive(:state).and_return([white_piece, nil, nil])
        allow(white_piece).to receive(:see?).and_return(true)
        allow(white_piece).to receive(:path_to).and_return([1])
        # setup stub for check check whenever that is figured out
        result = board.valid_move?(0, 2, 'white')
        expect(result).to be true
      end
    end
  end

  describe '#move' do
    before do
      allow(board).to receive(:state).and_return([white_piece, nil, nil])
      allow(white_piece).to receive(:position=)
      allow(white_piece).to receive(:en_passant_position)
    end
    context 'Destination is unoccupied' do
      it 'Board state reflects move' do
        board.move(0, 2)
        result = board.state
        expect(result).to eq([nil, nil, white_piece])
      end
      it 'Piece is sent new position' do
        expect(white_piece).to receive(:position=)
        board.move(0, 2)
      end
    end
    context 'Destination is occupied' do
      it 'Board state reflects move' do
        allow(board).to receive(:state).and_return([white_piece, nil, black_piece])
        board.move(0, 2)
        result = board.state
        expect(result).to eq([nil, nil, white_piece])
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
