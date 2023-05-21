# frozen_string_literal: true

require './instructions'

# class representing a full game of Hangman
class Game
  include Instructions
  attr_accessor :secret_word

  def initialize
    @dictionary = File.open('dictionary.txt', 'r')
    @secret_word = random_word
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
end
