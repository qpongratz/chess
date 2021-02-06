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

  def see?(args)
    board = args[:board]
    destination = args[:destination]
  end

  def transformations
    orthogonal + diagonal + castling
  end

  def castling
    moves = []
    moves.push([2, 0]) if king_castle?
    moves.push([-2, 0]) if queen_castle?
    moves
  end

  def queen_castle?
    !(moved || queen_rook.moved)
  end

  def king_castle?
    !(moved || king_rook.moved)
  end

  def to_s
    if color == 'white'
      '♔'
    else
      '♚'
    end
  end
end
