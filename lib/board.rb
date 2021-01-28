# frozen_string_literal: true

require_relative 'conversions'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require 'pry'

# Manages board state
class Board
  attr_reader :state

  def initialize(state = default_state)
    @state = state
    puts state
    puts state.length
  end

  def valid_move?(start, destination, player)
    piece_to_move = state[start]
    return false if piece_to_move.nil?
    return false unless piece_to_move.color == player.color
    return false unless state[destination].nil? || piece_to_move.color != state[destination].color
    return false unless piece_to_move.see?(destination)

    path = piece_to_move.path_to(destination)
    path.each { |spot| return false unless state[spot].nil? }
    # If it makes this move, will king of same color player be in check?
    true
  end

  def check?(color)
    # find king of that color, and note it's position
    # ask any piece of other color if their position to king's position is valid_move?
    # If any opposing piece does have a valid move, store that path in a threat array?
  end

  def no_moves?(color)
    # go through each spot in array.
    # If piece color matches color given, ask for their sight.
    # Ask piece if each move in their sight is a valid move.
    # If ever a valid_move? then return false
    # if it gets to the end of the array, return true
  end

  def default_state
    piece_row('black', 0) +
      pawn_row('black', 8) +
      Array.new(32) +
      pawn_row('black', 48) +
      piece_row('white', 56)
  end

  private

  def pawn_row(color, start)
    Array.new(8)
    # row = []
    # 8.times do
    #   row << Pawn.new(color, start)
    #   start += 1
    # end
    # row
  end

  def piece_row(color, start)
    [Rook.new(color, start),
     Knight.new(color, start + 1),
     Bishop.new(color, start + 2),
     Queen.new(color, start + 3),
     King.new(color, start + 4),
     Bishop.new(color, start + 5),
     Knight.new(color, start + 6),
     Rook.new(color, start + 7)]
  end


end

class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end
end


my_board = Board.new
my_player = Player.new('black')
p my_board.valid_move?(0, 57, my_player)

