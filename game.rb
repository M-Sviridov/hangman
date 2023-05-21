# frozen_string_literal: true

require './instructions'
require './display'

# class representing a full game of Hangman
class Game
  include Instructions
  include Display

  attr_accessor :secret_word

  def initialize
    @dictionary = File.open('dictionary.txt', 'r')
    @secret_word = random_word
  end

  def start
    puts instructions
  end

  def random_word
    array = []
    @dictionary.each_line do |line|
      line.chomp
      array << line
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
end
