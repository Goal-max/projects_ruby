class Patterns
  attr_reader :colours, :colours_indices, :board
  attr_accessor :colours_paired,
                :base_patterns,
                :base_pattern_feedback,
                :second_patterns,
                :secret_code_guess,
                :second_pattern_total_reds_found

  def initialize(board, colours)
    @board = board
    @colours = colours.shuffle
    @colours_paired = divide_into_pairs
    @base_patterns = create_base_pattern
    @base_pattern_feedback = {}
    @second_patterns = []
    @secret_code_guess = create_secret_code_guess_array
    @second_pattern_total_reds_found = 0
  end

  def divide_into_pairs
    pair = []
    until colours.empty?
      pair << colours.shift(2)
    end
    pair
  end

  def create_base_pattern
    pattern_list = []
    colours_paired.each do |colour_pair|
      pattern_list << create_first_pattern(colour_pair[0], colour_pair[1])
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

      pattern = base_patterns[0].each_with_index.map do |element, second_index|
        if index == second_index
          element == first_colour ? second_colour : first_colour
        else
          element
        end
      end
      [index, pattern]
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
      second_patterns[0][1]
    end
  end

  def clear_patterns
    self.second_pattern_total_reds_found = 0
    base_patterns.shift
    self.second_patterns = []
  end
end
