# frozen_string_literal: true

require_relative 'piece'

# Controls rook specific bits.
class Pawn < Piece
  attr_reader :forward, :moved, :enemy_color

  def post_initialize
    @range = 1
    @forward = (color == 'white' ? -1 : 1)
    @enemy_color = (color == 'white' ? 'black' : 'white')
    @moved = false
  end

  def position=(position)
    en_passant(position)
    @position = index_to_coordinates(position)
    @moved = true
    update_sight
  end

  def see?(args, actual_sight = [])
    return false unless sight.flatten(1).include?(args[:destination])

    board = args[:board]
    actual_sight.push(sight[0]) if board.state[sight[0][0]].nil?
    actual_sight.push(sight[1]) if board.colors_match?(sight[1][0], enemy_color) || board.en_passant_position == sight[1][0]
    actual_sight.push(sight[2]) if board.colors_match?(sight[2][0], enemy_color) || board.en_passant_position == sight[2][0]
    actual_sight.push(sight[3]) if !sight[3].nil? && board.state[sight[3][1]].nil?
    actual_sight.flatten(1).include?(args[:destination])
  end

  private

  def en_passant(position)
    @en_passant_position = (sight.flatten.include?(space_behind(position)) ? space_behind(position) : nil)
  end

  def space_behind(position)
    position - (8 * forward)
  end

  def update_sight
    super
    correct_sight
  end

  def correct_sight
    sight[3] && sight[3] = sight[0] + sight[3]
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
