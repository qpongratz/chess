# frozen_string_literal: true

require 'board'
require 'player'

describe Board do
  subject(:board) { described_class.new }
  let(:white_player) { instance_double(Player) }
  let(:white_piece) { instance_double(Piece) }
  let(:black_piece) { instance_double(Piece) }
  describe '#valid_move?' do
    before do
      allow(white_player).to receive(:color).and_return('white')
      allow(white_piece).to receive(:color).and_return('white')
      allow(black_piece).to receive(:color).and_return('black')
    end
    context 'Start position is empty' do
      it 'Returns false' do
        allow(board).to receive(:state).and_return([nil])
        result = board.valid_move?(0, 1, white_player)
        expect(result).to be false
      end
    end
    context 'Start position piece is not same color as player' do
    end
    context 'Destination is same color as player' do
    end
    context 'Destination is unreachable by piece' do
    end
    context 'Path to Destination is blocked by another piece' do
    end
    context 'Move will put player making move in check' do
    end
    context 'All checks pass' do
    end
  end
end