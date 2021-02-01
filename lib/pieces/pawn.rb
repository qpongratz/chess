# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Pawn < Piece
  attr_reader :forward

  def post_initialize
    @forward = (color == 'white' ? -1 : 1)
  end

  def transformations
    
  end
end