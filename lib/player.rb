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
      p coordinates
      return 'save' if coordinates[0] == 'save'

      start = player_input_to_index(coordinates[0])
      destination = player_input_to_index(coordinates[1])
      next unless board.valid_move?(start, destination, color)

      board.move(start, destination)
      board.promote(choose_promotion, color) unless board.promotion.nil?
      break
    end
  end

  private

  def choose_promotion(input = '')
    #display_promotion_options
    puts "1, queen. 2, knight, 3, rook, 4, bishop"
    input = gets.chomp until input_valid_promotion?(input)
    input.to_i
  end

  def input(input = '')
    puts 'Input your start and end positions space separated Example: "A4 B2"'
    input = gets.chomp.downcase until input_valid_move?(input)
    input.split(' ')
  end

  def input_valid_move?(input)
    input.match(/[a-h][1-8] [a-h][1-8]/i) ||
      input == 'save'
  end

  def input_valid_promotion?(input)
    input.match(/[1-4]/)
  end
end
