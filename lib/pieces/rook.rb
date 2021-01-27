# frozen_string_literal: true

require_relative 'piece'
require_relative '../conversions'

# Controls rook specific bits.
class Rook < Piece
  include Conversions

  attr_reader :range
  
  def post_initialize
    @range = 7
  end
  
  def path_to_position(args)
    start_coordinate = index_to_coordinates(args[:start])
    end_coordinate = index_to_coordinates(args[:end])
    x = start_coordinate[0]
    y = start_coordinate[1]
    x_axis = line_of_coordinate(x)
    y_axis = line_of_coordinate(y)
    right = (x..(x + range)).to_a
    left = ((x - range)..x).to_a.reverse
    up = (y..(y + range)).to_a
    down = ((y - range)..y).to_a.reverse
    p paths = [right.zip(y_axis), left.zip(y_axis), x_axis.zip(up), x_axis.zip(down)]
    p "\n"
    p paths.keep_if { |path| path.include?(end_coordinate)}
  end



  # paths: four of them: x..x+range, x-range..x, y..y+range, y-range..y
  # x.zip(y) with horizontal and vertial lines
  # should create four arrays of coordinates

end

my_rook = Rook.new({ color: 'white' })
my_rook.path_to_position({ start: 0, end: 6 })