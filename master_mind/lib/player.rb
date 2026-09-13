require_relative 'board'
require_relative 'data'

class Player
  def initialize(role, board)
    @name = ask_input("Please enter name for #{role}")
    @board = board
  end
end
