# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Knight < Piece

  def post_initialize
    @range = 1
  end

  def transformations
    [[1, 2], [-2, -1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [2, 1]]
  end
end
