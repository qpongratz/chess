# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class King < Piece
  attr_reader :queen_rook, :king_rook, :board

  def post_initialize
    @range = 1
  end

  def setup(queen_rook, king_rook, board)
    @queen_rook ||= queen_rook
    @king_rook ||= king_rook
    @board ||= board
  end

  def transformations
    orthogonal + diagonal
  end

  def to_s
    if color == 'white'
      '♔'
    else
      '♚'
    end
  end
end
