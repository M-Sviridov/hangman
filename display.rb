# frozen_string_literal: true

require './colorable'

# module that displays certain information for the game
module Display
  using Colorable

  def reveal_word
    @player_word.each { |char| print char.fg_color(:aurora3) }
    puts ''
    puts "\nLetters already used: #{@letters_guessed.join}".fg_color(:aurora5)
  end

  def game_start_text
    puts "\nYour random word has been chosen and it has #{@secret_word.length} letters".fg_color(:aurora3)
    reveal_word
  end

  def show_end_game_status
    if win?
      puts "\nCongratulations! You won.".fg_color(:aurora4)
    elsif incorrect_guesses == 8
      puts "\nSorry! You lost.".fg_color(:aurora1)
    end
  end

  def new_guess_text
    <<~TEXT

      Your turn to guess one letter.
      Alternatively, you can type 'save' or 'exit' to quit the game.

    TEXT
  end

  def incorrect_guess_text
    puts "\nPlease enter only one alphabetic character.".fg_color(:aurora1)
    puts "And a letter you haven't used already.".fg_color(:aurora1) 
  end
end
