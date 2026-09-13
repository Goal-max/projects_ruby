require_relative 'board'
require_relative 'data'

class Player
  attr_reader :name

  def initialize(role, board)
    @name = ask_input("Please enter name for #{role}")
    @board = board
  end

  def computer_code_maker
    code = codepeg_colours.sample(4) 
  end

end
