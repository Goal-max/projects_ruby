require_relative 'player'
require_relative 'methods'
require 'debug'

class Board
  include Methods

  def initialize
    @guesses_and_feedback = []
  end

  def guess_correct?(guess)
    guess.intersection(@secret_code).length == 4
  end

  def check_input(guess)
    keypegs = { red: 0, white: 0 }
    secret_code_no_matches = []
    guess_no_matches = []
    @secret_code.each_index do |index|
      if @secret_code[index] != guess[index]
        secret_code_no_matches << @secret_code[index]
        guess_no_matches << guess[index]
      else
        keypegs[:red] += 1
        secret_code_no_matches << nil
        guess_no_matches << nil
      end
    end
    guess_no_matches.each_index do |index|
      next if guess_no_matches[index].nil?

      colour_index = secret_code_no_matches.find_index(guess_no_matches[index])
      if colour_index
        secret_code_no_matches[colour_index] = nil
        keypegs[:white] += 1
      end
    end
    @guesses_and_feedback << [guess, keypegs]
  end

  def generate_code(colours)
    @secret_code = Array.new(4) { colours.sample }
  end

  def list_guesses_and_feedback
    puts 'All guesses and feedback:'
    @guesses_and_feedback.each do |guess_and_feedback|
      puts "Guess: #{guess_and_feedback[0]} \t Feedback: #{guess_and_feedback[1]}"
    end
  end
end
