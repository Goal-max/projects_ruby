require_relative 'board'
require_relative 'methods'

class Player
  attr_reader :name

  def initialize(board)
    @board = board
  end
end
