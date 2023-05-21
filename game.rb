# frozen_string_literal: true

require './instructions'
require './display'
require './colorable'

# class representing a full game of Hangman
class Game
  include Instructions
  include Display
  using Colorable

  attr_accessor :secret_word

  def initialize
    @dictionary = File.open('dictionary.txt', 'r')
    @secret_word = random_word
    @player_guess = set_blank_word
  end

  def start
    puts instructions
    user_choice_text
    launch_game
  end

  def random_word
    array = []
    @dictionary.each_line do |line|
      line.chomp
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
    game_start if game_option == 1
  end

  def new_guess
    loop do
      puts 'Your turn to guess one letter: '
      guess = gets.chomp
      return guess unless guess.match?(/\A[a-zA-Z]+\z/)

      puts 'Please enter only one alphabetic character.'
    end
  end
end

Game.new.start
