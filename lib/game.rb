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

  def turn_text
    display_board(board.state)
    puts "#{current_color}'s turn"
    puts 'You are in check' if board.check?(current_color)
  end

  def checkmate
    puts 'Checkmate. You lost and you won.'
  end

  def stalemate
    puts 'Stalemate; no one wins'
  end
end
