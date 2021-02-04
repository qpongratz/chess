# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Queen < Piece
  def transformations
    orthogonal + diagonal
  end

  def to_s
    if color == 'white'
      '♕'
    else
      '♛'
    end
  end
end
