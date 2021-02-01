# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Pawn < Piece
  attr_reader :forward, :moved

  def post_initialize
    @forward = (color == 'white' ? -1 : 1)
    @moved = false
  end

  def position=(position)
    @position = index_to_coordinates(position)
    update_sight
    @moved = true
  end

  def transformations
    
  end
end