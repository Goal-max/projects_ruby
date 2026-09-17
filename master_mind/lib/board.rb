require_relative 'player'
require_relative 'methods'

class Board
  include Methods

  def initialize
    @guesses_and_feedback = []
    @keypegs
  end

  def guess_correct?(guess)
    guess.intersection(@secret_code).length == 4
  end

  def check_input(guess)
  end

  def generate_code(colours)
    @secret_code = Array.new(4) { colours.sample }
  end
end
