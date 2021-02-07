# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'

# Controls the flow of the game.
class Game
  include Display
  attr_reader :players, :board

  def initialize
    @board = Board.new
    @players = [Player.new('white'), Player.new('black')]
  end

  def turn
    until board.no_moves?(current_color) == true
      turn_text
      status = current_player.input_move(board)
      return save if status == 'save'

      players.rotate!
    end
    board.check?(current_color) ? checkmate : stalemate
  end

  private

  def save
    puts 'You savea the game. Now how do we break out of the turn loop?'
  end

  def current_color
    current_player.color
  end

  def current_player
    players[0]
  end

  def next_color
    players[1].color
  end

  def turn_text
    display_board(board.state)
    display_turn(current_color, board.check?(current_color))
  end

  def checkmate
    display_checkmate(current_color, next_color)
  end

  def stalemate
    display_stalemate(current_color)
  end
end
