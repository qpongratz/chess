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
      it 'Returns false' do
        allow(board).to receive(:state).and_return([white_piece, nil, nil])
        allow(white_piece).to receive(:see?).and_return(true)
        allow(white_piece).to receive(:path_to).and_return([1])
        allow(board).to receive(:in_check_when_moved?).and_return(true)
        result = board.valid_move?(0, 2, 'white')
        expect(result).to be false
      end
    end
    context 'All checks pass' do
      it 'Returns true' do
        allow(board).to receive(:state).and_return([white_piece, nil, nil])
        allow(white_piece).to receive(:see?).and_return(true)
        allow(white_piece).to receive(:path_to).and_return([1])
        allow(board).to receive(:in_check_when_moved?).and_return(false)
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
    context 'A pawn moves onto a back row' do
      before do
        fake_state = Array.new(64)
        fake_state[8] = white_piece
        allow(white_piece).to receive(:instance_of?).and_return(Pawn)
        allow(board).to receive(:state).and_return(fake_state)
      end
      it 'Promotion stores the index of that pawn' do
        board.move(8, 0)
        result = board.promotion
        expect(result).to eq(0)
      end
    end
  end

  describe '#en_passant' do
    let(:white_pawn) { instance_double(Pawn) }
    let(:black_pawn) { instance_double(Pawn) }
    before do
      fake_state = [nil, nil, white_piece, nil, nil, nil, nil, white_pawn, black_pawn]
      allow(board).to receive(:en_passant_position).and_return(6)
      allow(white_pawn).to receive(:space_behind).and_return(8)
      allow(white_pawn).to receive(:en_passant_position)
      allow(white_pawn).to receive(:instance_of?).and_return(Pawn)
      allow(white_piece).to receive(:en_passant_position)
      allow(board).to receive(:state).and_return(fake_state)
    end
    context 'Piece was pawn and attacked en passant' do
      it 'Pawn that moved double is removed' do
        board.en_passant(white_pawn, 6)
        result = board.state[8]
        expect(result).to be nil
      end
    end
    context 'Piece is not pawn and moves to en passant square' do
      it 'Does not affect pawn that moved double' do
        board.en_passant(white_piece, 6)
        result = board.state[8]
        expect(result).to eq(black_pawn)
      end
    end
  end

  describe '#check?' do
    let(:white_king) { instance_double(King) }
    let(:black_king) { instance_double(King) }
    let(:black_pawn) { instance_double(Pawn) }
    before do
      fake_state = [black_pawn, white_king]
      allow(board).to receive(:white_king).and_return(white_king)
      allow(board).to receive(:black_king).and_return(black_king)
      allow(board).to receive(:state).and_return(fake_state)
    end
    context 'Player is not in check' do
      it 'Returns false' do
        allow(board).to receive(:valid_move?).and_return(false)
        result = board.check?('white')
        expect(result).to be false
      end
    end
    context 'Player is in check' do
      it 'Returns true' do
        allow(board).to receive(:valid_move?).and_return(true)
        result = board.check?('white')
        expect(result).to be true
      end
    end
  end

  describe '#no_moves?' do
    let(:black_pawn) { instance_double(Pawn) }
    before do
      fake_state = [black_pawn]
      allow(board).to receive(:state).and_return(fake_state)
      allow(black_pawn).to receive(:sight).and_return([0, 1])
      allow(black_pawn).to receive(:color).and_return('black')
    end
    context 'Player has an available move' do
      it 'Returns false' do
        allow(board).to receive(:valid_move?).and_return(true)
        result = board.no_moves?('black')
        expect(result).to be false
      end
    end
    context 'Player has an available move' do
      it 'Returns true' do
        allow(board).to receive(:valid_move?).and_return(false)
        result = board.no_moves?('black')
        expect(result).to be true
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
