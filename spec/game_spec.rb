# frozen_string_literal: true

require 'board'
require 'player'
require 'game'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:white_player) { instance_double(Player) }
  let(:black_player) { instance_double(Player) }
  before do
    allow(game).to receive(:puts)
    allow(board).to receive(:state).and_return([nil])
    game.instance_variable_set(:@players, [white_player, black_player])
    game.instance_variable_set(:@board, board)
  end
  context 'There are still moves that can be made' do
    before do
      allow(board).to receive(:check?)
      allow(white_player).to receive(:color)
      allow(black_player).to receive(:color)
      allow(white_player).to receive(:input_move)
      allow(black_player).to receive(:input_move)
    end
    it 'Starts with the white player' do
      allow(board).to receive(:no_moves?).and_return(false, true)
      expect(white_player).to receive(:input_move).once
      game.turn
    end
    it 'Black player moves after white player' do
      allow(board).to receive(:no_moves?).and_return(false, false, true)
      expect(white_player).to receive(:input_move).once
      expect(black_player).to receive(:input_move).once
      game.turn
    end
    it 'White player moves again after black' do
      allow(board).to receive(:no_moves?).and_return(false, false, false, true)
      expect(white_player).to receive(:input_move).twice
      expect(black_player).to receive(:input_move).once
      game.turn
    end
  end
  context 'There are no moves to be made' do
    before do
      allow(board).to receive(:no_moves?).and_return(true)
      allow(white_player).to receive(:color)
      allow(black_player).to receive(:color)
    end
    it 'Calls checkmate if current player is in check' do
      allow(board).to receive(:check?).and_return(true)
      expect(game).to receive(:checkmate)
      game.turn
    end
    it 'Calls stalemate if current_player is not in check' do
      allow(board).to receive(:check?).and_return(false)
      expect(game).to receive(:stalemate)
      game.turn
    end
  end
end

# rubocop:enable Metrics/BlockLength
