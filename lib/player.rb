# frozen_string_literal: true

require_relative 'conversions'

# Handles player inputs
class Player
  include Conversions
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def input_move(board)
    loop do
      coordinates = input
      start = player_input_to_index(coordinates[0])
      destination = player_input_to_index(coordinates[1])
      if board.valid_move?(start, destination, color)
        board.move(start, destination)
        break
      end
    end
  end

  def input(input = '')
    puts 'Input your start and end positions space separated Example: "A4 B2"'
    input = gets.chomp until input.match(/[a-h][1-8] [a-h][1-8]/i)
    input.split(' ')
  end
end
