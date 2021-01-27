# frozen_string_literal: true

# Controls the things all pieces need to be able to do.
class Piece
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = index_to_coordinates(position)
    post_initialize
  end

  def position=(position)
    @position = index_to_coordinates(position)
    update_sight
  end

  private

  def line_of_coordinate(coord)
    Array.new(range, coord)
  end

  def x
    position[0]
  end

  def y
    position[1]
  end
end
 