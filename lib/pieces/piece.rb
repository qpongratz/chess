# frozen_string_literal: true

# Controls the things all pieces need to be able to do.
class Piece
  attr_reader :color, :position
  
  def initialize(args)
    @color = args[:color]
    @position = args[:position]
  end
end
