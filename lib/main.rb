# frozen_string_literal: true

require_relative 'game'
require_relative 'display'

# Starts the game and manages flow.
class Main
  include Display
  attr_reader :current_game, :save_list

  def initialize
    @current_game = Game.new
    choose_mode
  end

  def create_save_list
    @save_list = {}
    saves = Dir.open('saves')
    i = 0
    saves.each do |file|
      if file.include?('yml')
        @save_list[i.to_s] = file
        i += 1
      end
    end
    display_save_select(save_list)
  end

  def choose_mode
    display_mode_prompt
    choice = gets.chomp
    return new_game if choice == '1'
    return load_game if choice == '2'

    display_invalid_input
    choose_mode
  end

  def load_game
    create_save_list
    selection = gets.chomp
    if save_list.key?(selection)
      current_game.load_game(save_list[selection])
      current_game.turn
    else
      display_invalid_input
      load_game
    end
  end

  def new_game
    current_game.turn
  end
end

Main.new
