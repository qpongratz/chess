# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Pawn < Piece
  attr_reader :forward, :moved

  def post_initialize
    @range = 1
    @forward = (color == 'white' ? -1 : 1)
    @moved = false
  end

  def position=(position)
    @position = index_to_coordinates(position)
    @moved = true
    update_sight
  end

  def transformations
    moves = [[0, forward], [-1, forward], [1, forward]]
    moves.push([0, forward * 2]) unless moved
    moves
  end
end

my_pawn = Pawn.new('white', 50)
p my_pawn.sight
p my_pawn.position = (41)
p my_pawn.sight