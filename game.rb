# frozen_string_literal: true

require './instructions'
require './display'
require './colorable'

# class representing a full game of Hangman
class Game
  include Instructions
  include Display
  using Colorable

  attr_accessor :secret_word, :player_guess, :player_word

  def initialize
    @dictionary = File.open('dictionary.txt', 'r')
    @secret_word = random_word.split('')
    @player_word = set_blank_word
    @player_guess = nil
    p @secret_word
  end

  def start
    puts instructions
    user_choice_text
    launch_game
  end

  def random_word
    array = []
    @dictionary.each_line do |line|
      line.chomp!
      array << line if line.length.between?(5, 12)
    end
    array.sample
  end

  def set_blank_word
    array = []
    @secret_word.length.times do
      array << '_'
    end
    array
  end

  def game_option
    loop do
      option = gets.chomp.to_i
      return option if [1, 2].include?(option)

      puts 'Please enter either 1 or 2.'.fg_color(:aurora1)
    end
  end

  def launch_game
    incorrect_guesses = 0
    return unless game_option == 1

    game_start
    until win? || incorrect_guesses == 8
      @player_guess = new_guess
      incorrect_guesses += 1 unless good_guess?
      puts "\nCareful, only one more guess!".fg_color(:aurora1) if incorrect_guesses == 7
      update_player_word
      reveal_word
    end

    if win?
      puts "\nCongratulations! You won.".fg_color(:aurora4)
    elsif incorrect_guesses == 8
      puts "\nSorry! You lost.".fg_color(:aurora1)
    end
  end

  def new_guess
    loop do
      puts "\nYour turn to guess one letter: "
      guess = gets.chomp
      return guess if guess.match?(/\A[a-zA-Z]+\z/) && guess.length == 1

      puts "\nPlease enter only one alphabetic character.".fg_color(:aurora1)
    end
  end

  def good_guess?
    @secret_word.include?(@player_guess)
  end

  def update_player_word
    @secret_word.each_with_index do |char, index|
      @player_word[index] = char if char == @player_guess
    end
  end

  def win?
    @player_word.join == @secret_word.join
  end
end

Game.new.start
