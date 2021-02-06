# frozen_string_literal: true

require_relative 'piece'
require 'pry'

# Controls rook specific bits.
class Pawn < Piece
  attr_reader :forward, :moved, :enemy_color

  def post_initialize
    @range = 1
    @forward = (color == 'white' ? -1 : 1)
    @enemy_color = (color == 'white' ? 'black' : 'white')
  end

  def position=(position)
    en_passant(position)
    @position = index_to_coordinates(position)
    update_sight
  end

  def see?(args)
    destination = args[:destination]
    board = args[:board]
    possible_verticals = vertical_destinations.select { |spot| board.state[spot].nil? }
    possible_diagonals = diagonal_destinations.select do |spot|
      board.en_passant_position == spot || board.colors_match?(spot, enemy_color)
    end
    (possible_diagonals + possible_verticals).flatten.include?(destination)
  end

  def to_s
    if color == 'white'
      '♙'
    else
      '♟︎'
    end
  end

  def space_behind(position)
    position - (8 * forward)
  end

  private

  def en_passant(position)
    @en_passant_position = (sight.flatten.include?(space_behind(position)) ? space_behind(position) : nil)
  end

  def update_sight
    super
    correct_sight
  end

  def correct_sight
    sight[3] && sight[3] = sight[0] + sight[3]
  end

  def vertical_destinations
    destinations = [sight.flatten.first]
    destinations.push(sight.flatten.last) if sight.length == 4
    destinations
  end

  def diagonal_destinations
    destinations = [sight[1], sight[2]]
    destinations.flatten
  end

  def transformations
    moves = [[0, forward], [-1, forward], [1, forward]]
    moves.push([0, forward * 2]) unless moved
    moves
  end
end

# my_pawn = Pawn.new('white', 63)
# p my_pawn.sight
# p my_pawn.en_passant_position
# p my_pawn.position = (47)
# p my_pawn.en_passant_position
# p my_pawn.position = (38)
# p my_pawn.en_passant_position
