require_relative 'board'
require_relative 'methods'

class Player
  attr_reader :name

  def initialize(role, board)
    @name = ask_input("Please enter name for #{role}")
    @board = board
  end
end
