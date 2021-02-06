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
    # probably don't need board here actually
  end

  def see?(args)
    update_sight
    destination = args[:destination]
    return false unless sight.flatten(1).include(args[:destination])

    if ((position_as_index + 2) == destination) || ((position_as_index - 2) == destination)
      castle_check(destination)
    else
      true
    end
  end

  def castle_check(destination)
    rook = (position_as_index > destination ? queen_rook : king_rook)
    mid_point = (position_as_index > destination ? (position_as_index - 1) : (position_as_index + 1))

    if !mate_during_castle?(mid_point, destination) && board.valid_move?(rook.position_as_index, mid_point, color)
      false
    else
      @castled = true
      true
    end
  end

  def mate_during_castle?(mid_point, destination)
    board.check?(color) ||
      board.in_check_when_moved?(position_as_index, mid_point, color) ||
      board.in_check_when_moved?(position_as_index, destination, color)
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
