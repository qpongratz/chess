# frozen_string_literal: true

# Handles player inputs
class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def input_move(move)
  end
end
