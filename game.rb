# frozen_string_literal: true

require './instructions'
require './display'
require './colorable'
require 'yaml'

# class representing a full game of Hangman
class Game
  include Instructions
  include Display
  using Colorable

  attr_accessor :secret_word, :player_guess, :player_word, :incorrect_guesses

  def initialize
    @dictionary = File.open('dictionary.txt', 'r')
    @secret_word = random_word.split('')
    @player_word = set_blank_word
    @player_guess = nil
    @incorrect_guesses = 0
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
    if game_option == 1
      game_start
    else
      files_list
      game = load_game("./saves/#{pick_save}")
      @secret_word = game.secret_word
      @player_word = game.player_word
      @player_guess = game.player_guess
      @incorrect_guesses = game.incorrect_guesses
      game_start
    end

    until win? || @incorrect_guesses == 8
      @player_guess = new_guess
      @incorrect_guesses += 1 unless good_guess?
      puts "\nCareful, only one more guess!".fg_color(:aurora1) if @incorrect_guesses == 7
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
      puts "Alternatively, you can type 'save' or 'exit' to quit the game."
      guess = gets.chomp
      if guess.match?(/\A[a-zA-Z]+\z/) && guess.length == 1
        return guess
      elsif guess == 'save'
        puts 'save the game'
        save_game
        exit
      elsif guess == 'exit'
        exit
      end

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

  def save_game
    File.open(random_file_name, 'wb') do |file|
      file.puts YAML.dump(self)
    end
  end

  def random_file_name
    loop do
      filename = "Game_##{rand(1..100)}.yaml"
      filepath = File.join('./saves', filename)
      puts filepath

      return filepath unless File.exist?(filepath)
    end
  end

  def load_game(filepath)
    YAML.unsafe_load_file(filepath)
  end

  def files_list
    puts "\n#{'  #  '.bg_color(:frost2)} File Name(s)\n\n"
    files = Dir.entries('./saves').select { |f| File.file?(File.join('./saves', f)) }
    files.each_with_index { |file, index| puts "  #{index + 1}  ".bg_color(:frost2) + " #{file}\n\n" }
    files
  end

  def pick_save
    loop do
      puts 'Enter the save number you wish to load: '
      save_num = gets.chomp.to_i

      return files_list[save_num - 1] if save_num.between?(1, files_list.length)

      puts 'Incorrect save number.'
    end
  end
end

game = Game.new.start

# load_game('./saves/Game_#3.txt')
