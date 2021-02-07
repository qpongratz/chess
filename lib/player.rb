# frozen_string_literal: true

require_relative 'display'
require_relative 'conversions'

# Handles player inputs
class Player
  include Conversions
  include Display
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def input_move(board)
    loop do
      coordinates = input
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

  def choose_promotion
    display_promotion_options
    input = gets.chomp
    input = gets.chomp until input_valid_promotion?(input)
    input.to_i
  end

  def input
    display_input_prompt
    input = gets.chomp.downcase
    input = gets.chomp.downcase until input_valid_move?(input)
    input.split(' ')
  end

  def input_valid_move?(input)
    input.match?(/[a-h][1-8] [a-h][1-8]/i) ||
      input == 'save' ||
      (puts 'Invalid Input')
  end

  def input_valid_promotion?(input)
    input.match?(/[1-4]/) || (puts 'Invalid Input')
  end
end
