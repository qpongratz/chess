# frozen_string_literal: true

# Controls the things all pieces need to be able to do.
class Piece
  attr_reader :color

  def initialize(args)
    @color = args[:color]
    post_initialize
  end

  def line_of_coordinate(coord)
    Array.new(range + 1, coord)
  end
end
 