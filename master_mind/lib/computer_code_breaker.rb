class Computer
  attr_reader :colours

  def initialize(board, colours)
    @board = board
    @colours = create_colour_pair(colours)
  end

  def create_colour_pairs(colours)
    colours_copy = colours
    colour_pairs = []
    colour_pairs << colours_copy.shift(2) until colours_copy.empty?
    colour_pairs
  end
  
  def create_guess(pair)
    @colour_pair = colours[0]
    pattern = [0, 1, 0, 1]
    guess = []
    pattern.each do |element|
      guess << colour_pair[element]
    end
    guess
  end
end
