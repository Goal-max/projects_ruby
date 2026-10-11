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

  def analyse_feedback
    if second_patterns.empty?
      self.base_pattern_feedback = board.guesses_and_feedback[-1][1]

  end
  last_feedback = board.guesses_and_feedback[-1][1]

#patterns creates second patterns if it has not been created yet
  if patterns.second_patterns.empty?
    patterns.base_pattern_feedback = last_feedback
    total_red_whites = patterns.base_pattern_feedback[:total_red_white]
    if total_red_whites == 0
      patterns.base_patterns.shift
    elsif total_red_whites > 0 
      patterns.create_second_pattern(patterns.colours_paired[0])
    end
    patterns.colours_paired.shift
  else
    secretcode_position_index = patterns.second_patterns[0][0]
    base_pattern_total_red_white =
      patterns.base_pattern_feedback[:total_red_white]
    base_pattern_whites = patterns.base_pattern_feedback[:white]
  #patterns checks for change in feedback reds 
    base_pattern_reds = patterns.base_pattern_feedback[:red]
    last_feedback_reds = last_feedback[:red]
    change_in_reds = last_feedback_reds - base_pattern_reds
  #store colour worked out
    case change_in_reds
    when -1
      patterns.secret_code_guess[secretcode_position_index] =
        patterns.base_patterns[0][secretcode_position_index]
    when 1
      patterns.secret_code_guess[secretcode_position_index] =
        patterns.second_patterns[0][1][secretcode_position_index]
    end
    patterns.second_pattern_total_reds_found += 1 if change_in_reds != 0
  # reset pattern if < 2 red/white
    if patterns.second_pattern_total_reds_found ==
       base_pattern_total_red_white &&
       base_pattern_reds != 2 &&
       base_pattern_whites != 2
      patterns.clear_patterns
  #reset if last second pattern guessed
    elsif patterns.second_patterns.length == 1
      patterns.clear_patterns
    else
      patterns.second_patterns.shift
    end
  end
end
