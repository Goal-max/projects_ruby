class Computer
  def initialize(board, colours)
    @board = board
    @colours = colours
  end

  colour_pairs = []
  i = 0
  until i == colours.length
    colour_pairs << [colours.shift(2)]
  end
  
end
