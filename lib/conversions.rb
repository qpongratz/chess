# frozen_string_literal: true

# Converts between coordinates and incices.
module Conversions
  def index_to_coordinates(index)
    x = index % 8
    y = index / 8
    [x, y]
  end

  def coordinates_to_index(coordinates)
    x = coordinates[0]
    y = coordinates[1]
    x + (y * 8)
  end
end
