# frozen_string_literal: true

# module to include and print instructions of Hangman  before start of game
module Instructions
  def instructions
    <<~TEXT

      Welcome the the Hangman game!

      Here are the instructions (for those who don't know them yet):

      Each game of Hangman consists of guessing a word between 5 and 12 characters long.

      Each turn, you guess one letter. To win, you must find all the characters in the
      random word, before you use your maximum of 8 incorrect guesses.

      Good luck!

      Do you want to:

      \e[41m  1  \e[0m Play a new game
      \e[42m  2  \e[0m Load a saved game

    TEXT
  end
end
