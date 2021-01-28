# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Rook < Piece
  def transformations
    orthogonal
  end
end

# my_rook = Rook.new('white', 0)
# p my_rook.sight
