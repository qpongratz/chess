# frozen_string_literal: true

require_relative 'conversions'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require 'pry'

# Manages board state
class Board
  attr_reader :state, :en_passant_position, :white_king, :black_king

  def initialize(state = default_state)
    @state = state
    setup_kings
  end

  def valid_move?(start, destination, player)
    piece_to_move = state[start]
    return false unless colors_match?(start, player.color)
    return false if colors_match?(destination, player.color)
    return false unless piece_to_move.see?({ destination: destination, board: self })

    path = piece_to_move.path_to(destination)
    path.each { |spot| return false unless state[spot].nil? }
    # return false if check on color of simulated move
    true
  end

  def move(start, destination)
    piece_to_move = state[start]
    state[start] = nil
    state[destination] = piece_to_move
    piece_to_move.position = (destination)
    @en_passant_position = piece_to_move.en_passant_position
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

  private

  def setup_kings
    @black_king = state[4]
    @white_king = state[60]
    black_king.setup(state[0], state[7], self)
    white_king.setup(state[56], state[63], self)
  end

  def default_state
    piece_row('black', 0) +
      pawn_row('black', 8) +
      Array.new(32) +
      pawn_row('white', 48) +
      piece_row('white', 56)
  end

  def pawn_row(color, start)
    row = []
    8.times do
      row << Pawn.new(color, start)
      start += 1
    end
    row
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

  def colors_match?(position, color)
    if state[position].nil?
      false
    else
      state[position].color == color
    end
  end
end
