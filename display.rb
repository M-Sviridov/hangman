# frozen_string_literal: true

# module that displays certain information for the game
module Display
  def reveal_word
    @player_guess.each { |char| print char }
    puts ''
  end
end
