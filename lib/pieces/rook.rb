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



  def path_to_position(end_index)
    end_coordinate = index_to_coordinates(end_index)
    x = position[0]
    y = position[1]
    x_axis = line_of_coordinate(x)
    y_axis = line_of_coordinate(y)
    right = (x..(x + range)).to_a
    left = ((x - range)..x).to_a.reverse
    up = (y..(y + range)).to_a
    down = ((y - range)..y).to_a.reverse
    p paths = [right.zip(y_axis), left.zip(y_axis), x_axis.zip(up), x_axis.zip(down)]
    puts "\n"
    p path = paths.keep_if { |path| path.include?(end_coordinate)}
    p path = path.flatten(1)
    p index_of_end = path.find_index(end_coordinate)
    p path.slice(1, index_of_end - 1)
  end

end

# apply each transformation range times.
# transformations should do all directions

my_rook = Rook.new('white', 0)
# p my_rook.sight
p my_rook.sight
