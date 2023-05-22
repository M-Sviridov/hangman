# frozen_string_literal: true

require './instructions'
require './display'
require './colorable'
require './game_management'
require 'yaml'

# class representing a full game of Hangman
class Game
  include Instructions
  include Display
  include GameManagement
  using Colorable

  attr_accessor :secret_word, :player_guess, :player_word, :incorrect_guesses, :letters_guessed

  def initialize
    @dictionary = File.open('dictionary.txt', 'r')
    @secret_word = random_word.split('')
    @player_word = set_blank_word
    @player_guess = nil
    @incorrect_guesses = 0
    @letters_guessed = []
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

      puts "\nPlease enter either 1 or 2.\n".fg_color(:aurora1)
    end
  end

  def launch_game
    unless game_option == 1
      files_list
      load_game("./saves/#{pick_save}")
    end
    game_start_text

    new_turn until win? || @incorrect_guesses == 8

    show_end_game_status
  end

  def new_turn
    @player_guess = new_guess
    @incorrect_guesses += 1 unless good_guess?
    puts "\nCareful, only one more guess!\n".fg_color(:aurora1) if @incorrect_guesses == 7
    update_player_word
    reveal_word
  end

  def new_guess # rubocop:disable Metrics/MethodLength
    loop do
      puts new_guess_text
      guess = gets.chomp
      if guess.match?(/\A[a-zA-Z]+\z/) && guess.length == 1
        @letters_guessed << guess unless @letters_guessed.include?(guess)
        return guess
      elsif guess == 'save'
        save_game
        exit
      elsif guess == 'exit'
        exit
      end
      incorrect_guess_text
    end
  end

  def valid_guess?(guess)
    guess.match?(/\A[a-zA-Z]+\z/) && guess.length == 1 && !@letters_guessed.include?(guess)
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
