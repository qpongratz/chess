# frozen_string_literal: true

require_relative '../conversions'

# Controls the things all pieces need to be able to do.
class Piece
  include Conversions

  attr_reader :color, :position, :sight, :range, :en_passant_position, :moved

  def initialize(color, position)
    @color = color
    @position = index_to_coordinates(position)
    @range = 7
    @moved = false
    post_initialize
    update_sight
  end

  def position=(position)
    @position = index_to_coordinates(position)
    @moved = true
    update_sight
  end

  def see?(args)
    sight.flatten(1).include?(args[:destination])
  end

  def path_to(position)
    single_path = sight.select { |path| path.include?(position) }.flatten(1)
    popped_position = single_path.pop until popped_position == position
    single_path
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
    build_sight
    prune_sight
    translate_sight
  end

  def build_sight
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

  def translate_sight
    @sight = sight.map do |coordinate_array|
      coordinate_array.map { |coordinate| coordinates_to_index(coordinate) }
    end
  end

  def prune_sight
    @sight = sight.map do |coordinate_array|
      coordinate_array.shift
      coordinate_array.keep_if { |coordinate| coordinate[0].between?(0, 7) && coordinate[1].between?(0, 7) }
    end
  end
end
