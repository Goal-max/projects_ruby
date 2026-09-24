class Computer
  attr_reader :colours, :colours_indices, :colours_paired
  attr_accessor :colour_patterns, :incorrect_colours

  def initialize(board, colours)
    @board = board
    @colours = colours
    @colours_paired = divide_into_pairs
    @colour_patterns = base_pattern
    @incorrect_colours = []
  end

  def divide_into_pairs
    pair = []
    i = 0
    while i < colours.length
      pair << [colours[i], colours[i + 1]]
      i += 2
    end
    pair
  end

  def base_pattern
    pattern_list = []
    colours_paired.each do |colour_pair|
      first_colour = colour_pair[0]
      second_colour = colour_pair[1]
      pattern_list << create_first_pattern(first_colour, second_colour)
    end
    pattern_list
  end

  def create_first_pattern(first_colour, second_colour)
    [first_colour, first_colour, second_colour, second_colour]
  end

# create below only if above >= 1 red/white. Unshift onto array patterns list
  def create_second_pattern(first_colour)
    colour_patterns << [first_colour, first_colour, first_colour, first_colour]
  end

  def take_pattern
    colour_patterns[0]
  end
  
  def remove_pattern
    colour_patterns.shift
  end
end
