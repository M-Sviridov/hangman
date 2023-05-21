# frozen_string_literal: true

require './colorable'

# module to include and print instructions of Hangman  before start of game
module Instructions
  using Colorable

  def instructions
    <<~TEXT

      Welcome the the Hangman game!

      Here are the instructions (for those who don't know them yet):

      Each game of Hangman consists of guessing a word between 5 and 12 characters long.

      Each turn, you guess one letter. To win, you must find all the characters in the
      random word, before you use your maximum of 8 incorrect guesses.

      Good luck!

      Do you want to:

    TEXT
  end

  def user_choice_text
    puts "#{'  1  '.bg_color(:frost1)} Play a new game"
    puts "#{'  2  '.bg_color(:frost3)} Load a saved game\n\n"
  end
end
