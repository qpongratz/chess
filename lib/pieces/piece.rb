# frozen_string_literal: true

# Controls the things all pieces need to be able to do.
class Piece
  attr_reader :color, :position, :sight

  def initialize(color, position)
    @color = color
    @position = index_to_coordinates(position)
    post_initialize
  end

  def position=(position)
    @position = index_to_coordinates(position)
    update_sight
  end

  def update_sight
    @sight = transformations.map do |direction|
      line = [position]
      while line.length <= range do
        new_x = line.last[0] + direction[0]
        new_y = line.last[1] + direction[1]
        line.push([new_x, new_y])
      end
      line
    end
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
 