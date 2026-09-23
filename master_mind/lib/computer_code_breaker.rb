class Computer
  attr_reader :colours
  attr_accessor :colour_patterns

  def initialize(board, colours)
    @board = board
    @colours = colours
    @colour_patterns
  end

=begin
  def create_colour_pairs(colours)
    colours_copy = colours
    colour_pairs = []
    colour_pairs << colours_copy.shift(2) until colours_copy.empty?
    colour_pairs
  end
=end

  colours_indices = colours.each_index.map do |index|
    index
  end
  until colours_indices.empty?
    index_pair = colours_indices.shift(2)
    first_index = index_pair[0]
    second_index = index_pair[1]
    create_pattern(first_index, second_index)
  end

  def create_first_pattern(first_index, second_index)
    [first_index, first_index, second_index, second_index]
  end

# create below only if above >= 1 red/white. Unshift onto array patterns list
  def create_second_pattern(first_index)
    [first_index, first_index, first_index, first_index]
  end

  def create_guess(index_pattern)
    guess = []
    index_pattern.each do |element|
      guess << colours[element]
    end
    guess
  end
end
