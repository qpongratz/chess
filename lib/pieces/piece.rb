# frozen_string_literal: true

require_relative '../conversions'

# Controls the things all pieces need to be able to do.
class Piece
  include Conversions

  attr_reader :color, :position, :sight, :range

  def initialize(color, position)
    @color = color
    @position = index_to_coordinates(position)
    @range = 7
    post_initialize
    update_sight
  end

  def position=(position)
    @position = index_to_coordinates(position)
    update_sight
  end

  private

  def orthogonal
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
  
  def diagonal
    [[1, 1], [-1, -1], [-1, 1], [1, -1]]
  end

  def post_initialize
    nil
  end

  def update_sight
    @sight = transformations.map do |transformation|
      line = [position]
      range.times do
        new_x = line.last[0] + transformation[0]
        new_y = line.last[1] + transformation[1]
        line.push([new_x, new_y])
      end
      line
    end
  end
end
