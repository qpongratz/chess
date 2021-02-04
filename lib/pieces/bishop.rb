# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Bishop < Piece
  def transformations
    diagonal
  end
end
