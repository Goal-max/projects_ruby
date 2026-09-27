class Computer
  attr_reader :colours, :colours_indices
  attr_accessor :colours_paired,
                :base_patterns,
                :base_pattern_feedback,
                :incorrect_colours,
                :second_patterns,
                :secret_code_guess,
                :second_pattern_total_reds_found

  def initialize(board, colours)
    @board = board
    @colours = colours
    @colours_paired = divide_into_pairs
    @base_patterns = create_base_pattern
    @base_pattern_feedback = {}
    @second_patterns = []
    @incorrect_colours = []
    @secret_code_guess = create_secret_code_guess_array
    @second_pattern_total_reds_found = 0
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

  def create_second_pattern(colour_pair)
    first_colour = colour_pair[0]
    second_colour = colour_pair[1]
    self.second_patterns = base_patterns[0].each_index.map do |index|
      next nil unless secret_code_guess[index].nil?

      base_patterns[0].each_with_index.map do |element, second_index|
        if index == second_index
          element == first_colour ? second_colour : first_colour
        else
          element
        end
      end
    end
    second_patterns.delete(nil)
  end

  def create_secret_code_guess_array
    Array.new(4) { nil }
  end

  def take_pattern
    if secret_code_guess.none?(nil)
      secret_code_guess
    elsif second_patterns.empty?
      base_patterns[0]
    else
      second_patterns[0]
    end
  end
end
