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

  def player_input_to_index(player_input)
    input_coord = player_input.split('')
    input_x = input_coord[0]
    input_y = input_coord[1]
    output_x = PLAYER_COLUMNS.index(input_x.upcase)
    output_y = PLAYER_ROWS.index(input_y)
    coordinates_to_index([output_x, output_y])
  end

  PLAYER_COLUMNS = %w[A B C D E F G H].freeze
  PLAYER_ROWS = %w[8 7 6 5 4 3 2 1].freeze
end
