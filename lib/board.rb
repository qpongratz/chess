# frozen_string_literal: true

require_relative 'conversions'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require 'pry'

# Manages board state
class Board
  attr_reader :state, :en_passant_position, :white_king, :black_king

  def initialize(state = nil)
    @state = state
    default_state if state.nil?
    find_kings if black_king.nil? || white_king.nil?
  end

  def valid_move?(start, destination, color)
    piece_to_move = state[start]
    return false unless colors_match?(start, color)
    return false if colors_match?(destination, color)
    return false unless piece_to_move.see?({ destination: destination, board: self })
    return false unless path_clear?(piece_to_move, destination)
    return false if in_check_when_moved?(start, destination, color)

    true
  end

  def move(start, destination)
    piece_to_move = state[start]
    state[start] = nil
    state[destination] = piece_to_move
    piece_to_move.position = (destination)
    en_passant(piece_to_move, destination)
  end

  def en_passant(piece_to_move, destination)
    if piece_to_move.instance_of?(Pawn) && destination == en_passant_position
      state[piece_to_move.space_behind(destination)] = nil
    end
    @en_passant_position = piece_to_move.en_passant_position
  end

  def check?(color)
    king = (color == 'white' ? white_king : black_king)
    enemy_color = (color == 'white' ? 'black' : 'white')
    kings_position = state.index(king)
    state.each_index do |index|
      valid_move?(index, kings_position, enemy_color) && (return true)
    end
    false
  end

  def no_moves?(color)
    state.each_with_index do |piece, index|
      next unless colors_match?(index, color)

      possible_moves = piece.sight.flatten
      possible_moves.each do |move|
        valid_move?(index, move, color) && (return false)
      end
    end
    true
  end

  def colors_match?(position, color)
    if state[position].nil?
      false
    else
      state[position].color == color
    end
  end

  def in_check_when_moved?(start, destination, color)
    test_state = state.map(&:clone)
    test_board = Board.new(test_state)
    test_board.move(start, destination)
    test_board.check?(color)
  end

  private

  def find_kings
    state.each do |spot|
      if spot.instance_of?(King)
        @white_king = spot if spot.color == 'white'
        @black_king = spot if spot.color == 'black'
      end
    end
  end

  def path_clear?(piece, destination)
    path = piece.path_to(destination)
    path.each { |spot| return false unless state[spot].nil? }
    true
  end

  def setup_kings
    @black_king ||= (state[4] = King.new('black', 4, state[0], state[7], self))
    @white_king ||= (state[60] = King.new('white', 60, state[56], state[63], self))
  end

  def default_state
    setup_board
    setup_kings
  end

  def setup_board
    @state = piece_row('black', 0) +
             pawn_row('black', 8) +
             Array.new(32) +
             pawn_row('white', 48) +
             piece_row('white', 56)
  end

  def pawn_row(color, start)
    row = []
    8.times do
      row << Pawn.new(color, start)
      start += 1
    end
    row
  end

  def piece_row(color, start)
    [Rook.new(color, start),
     Knight.new(color, start + 1),
     Bishop.new(color, start + 2),
     Queen.new(color, start + 3),
     nil,
     Bishop.new(color, start + 5),
     Knight.new(color, start + 6),
     Rook.new(color, start + 7)]
  end
end
