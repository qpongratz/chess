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
    display_board(board.state)
    until board.no_moves?(current_color) == true
      turn_text
      current_player.input_move(board)
      players.rotate!
    end
    display_board(board.state)    
    board.check?(current_color) ? checkmate : stalemate
  end

  private

  def current_color
    current_player.color
  end

  def current_player
    players[0]
  end

  def turn_text
    puts "#{current_color}'s turn"
    display_board(board.state)
    puts 'You are in check' if board.check?(current_color)
  end

  def checkmate
    puts 'Checkmate. You lost and you won.'
  end

  def stalemate
    puts 'Stalemate; no one wins'
  end
end
