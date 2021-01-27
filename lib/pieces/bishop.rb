# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Bishop < Piece
  def transformations
    diagonal
  end
end

my_bishop = Bishop.new('white', 0)
p my_bishop.sight
