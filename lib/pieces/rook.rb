# frozen_string_literal: true

require_relative 'piece'
require_relative '../conversions'

# Controls rook specific bits.
class Rook < Piece
  include Conversions

  attr_reader :range

  def post_initialize
    @range = 7
    update_sight
  end

  def transformations
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end

# apply each transformation range times.
# transformations should do all directions

my_rook = Rook.new('white', 0)
# p my_rook.sight
p my_rook.sight
