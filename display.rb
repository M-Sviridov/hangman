# frozen_string_literal: true

# require './game'
require './colorable'

# module that displays certain information for the game
module Display
  using Colorable

  def reveal_word
    @player_guess.each { |char| print char.fg_color(:aurora4) }
    puts ''
  end

  def game_start
    puts "\nYour random word has been chosen and it has #{@secret_word.length} letters".fg_color(:aurora4)
    reveal_word
  end
end
