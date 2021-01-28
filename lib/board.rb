# frozen_string_literal: true

require_relative 'conversions'
require_relative 'pieces/queen'
require 'pry'

# Manages board state
class Board
  attr_reader :state

  def initialize(state = default_state)
    @state = state
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
    # Otherwise return at some other point with false or a message
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
    array = Array.new(64)
    array[0] = Queen.new('white', 0)
    array
  end


end

class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end
end


my_board = Board.new
my_player = Player.new('white')
p my_board.valid_move?(0, 10, my_player)

