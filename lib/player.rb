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
    p coordinates = input
    # Get player input
    # Separate to start and destination variables
    # If it's valid, pass it to valid_move?(start, destination, color)
    # If that's valid, pass it to move(start, destination)
    # If not any of that, start over.
  end

  def input(input = '')
    puts 'Input your start and end positions space separated Example: "A4 B2"'
    input = gets.chomp until input.match(/[a-h][1-8] [a-h][1-8]/i)
    input
  end

end

my_player = Player.new('white')
my_player.input_move([nil])