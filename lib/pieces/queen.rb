# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Queen < Piece
  def transformations
    orthogonal + diagonal
  end
end

my_queen = Queen.new('white', 0)
p my_queen.sight
