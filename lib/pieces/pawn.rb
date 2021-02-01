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
    en_passant(position)
    @position = index_to_coordinates(position)
    @moved = true
    update_sight
  end

  def see?(position)
  end

  private

  def en_passant(position)
    @en_passant_position = (see?(space_behind(position)) ? space_behind(position) : nil)
  end

  def space_behind(position)
    position - (8 * forward)
  end

  def update_sight
    super
    correct_sight
  end

  def correct_sight
    sight[3] && sight[3] = sight[0] + sight[3]
  end

  def transformations
    moves = [[0, forward], [-1, forward], [1, forward]]
    moves.push([0, forward * 2]) unless moved
    moves
  end
end

my_pawn = Pawn.new('white', 63)
p my_pawn.sight
p my_pawn.en_passant_position
p my_pawn.position = (47)
p my_pawn.en_passant_position
p my_pawn.position = (38)
p my_pawn.en_passant_position
