# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class King < Piece

  def post_initialize
    @range = 1
  end

  def transformations
    orthogonal + diagonal
  end
end

# my_king = King.new('white', 0)
# p my_king.sight
