class Computer
  attr_reader :colours, :colours_indices
  attr_accessor :colours_paired,
                :base_patterns,
                :base_pattern_feedback,
                :incorrect_colours,
                :pattern_group2

  def initialize(board, colours)
    @board = board
    @colours = colours
    @colours_paired = divide_into_pairs
    @base_patterns = create_base_pattern
    @base_pattern_feedback = {}
    @pattern_group2 = []
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

  def create_base_pattern
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
  def create_second_pattern(colour_pair)
    first_colour = colour_pair[0]
    second_colour = colour_pair[1]
    patterns = base_patterns[0].each_index.map do |index|
      base_patterns[0].each_with_index.map do |element, second_index|
        if index == second_index
          element == first_colour ? second_colour : first_colour
        else
          element
        end 
      end
    end
    binding.b
    patterns
  end

  def take_pattern
    if pattern_group2.empty?
      base_patterns[0]
    else
      pattern_group2[0]
    end
  end

  def remove_pattern
    base_patterns.shift
  end
end
