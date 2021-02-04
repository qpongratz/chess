# frozen_string_literal: true

require 'board'
require 'player'

# Controls the flow of the game.
class Game
  def initialize
    board = Board.new
    players = [Player.new('white'), Player.new('black')]
  end

  def turn
    current_player = players[0]
    until board.no_moves?(current_player.color) == true
      put "#{current_player.color}'s turn"
      put 'You are in check' if board.check?(current_player.color)
      current_player.input_move(board)
      players.rotate
      current_player = players[0]
    end
    board.check?(current_player.color) ? checkmate : stalemate
  end

  private

  def checkmate
    'Checkmate. You lost and you won.'
  end

  def stalemate
    puts 'Stalemate; no one wins'
  end

end