# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Queen < Piece
  def transformations
    orthogonal + diagonal
  end
end

# my_queen = Queen.new('white', 0)
# p my_queen.sight
# coordinate_to_test = 8
# p my_queen.index_to_coordinates(coordinate_to_test)
# p my_queen.see?(coordinate_to_test)
# p my_queen.path_to(coordinate_to_test)
