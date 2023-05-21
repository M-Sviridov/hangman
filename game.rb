# frozen_string_literal: true

require './instructions'

# class representing a full game of Hangman
class Game
  include Instructions

  def initialize
    puts instructions
  end
end

Game.new
