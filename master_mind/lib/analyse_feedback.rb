class AnalyseFeedback
  attr_reader :patterns

  def initialize(board, patterns)
    @board = board
    @patterns = patterns
  end

  def analyse_feedback
    if patterns.second_patterns.empty?
      process_base_pattern_feedback
    else
      process_second_pattern_feedback
    end
  end

  def assign_base_variables
    base_pattern_feedback = @board.guesses_and_feedback[-1][1]
    @base_pattern_total_red_white = base_pattern_feedback[:total_red_white]
    @base_pattern_reds = base_pattern_feedback[:red]
    @base_pattern_whites = base_pattern_feedback[:white]
    @second_pattern_total_reds_found = 0
  end

  def process_base_pattern_feedback
    assign_base_variables
    if @base_pattern_total_red_white == 0
      patterns.base_patterns.shift
    else
      patterns.create_second_pattern(patterns.colours_paired[0])
    end
    patterns.colours_paired.shift
  end

  def create_second_pattern_variables
    @secret_code_position_index = patterns.second_patterns[0][0]
    @last_feedback = @board.guesses_and_feedback[-1][1]
  end

  def change_in_reds
    @last_feedback[:red] - @base_pattern_reds
  end

  def store_found_colour(change_in_reds)
    patterns.secret_code_guess[@secret_code_position_index] =
      case change_in_reds
      when -1
        base_pattern_colour_at_index
      when 1
        second_pattern_colour_at_index
      end
    @second_pattern_total_reds_found += 1 if change_in_reds != 0
  end

  def base_pattern_colour_at_index
    patterns.base_patterns[0][@secret_code_position_index]
  end

  def second_pattern_colour_at_index
    patterns.second_patterns[0][1][@secret_code_position_index]
  end

  def max_reds_found?
    @second_pattern_total_reds_found ==
      @base_pattern_total_red_white &&
      @base_pattern_reds != 2 &&
      @base_pattern_whites != 2
  end

  def last_second_pattern?
    patterns.second_patterns.length == 1
  end

  def adjust_patterns_for_next_guess
    if max_reds_found? || last_second_pattern?
      patterns.clear_patterns
    else
      patterns.second_patterns.shift
    end
  end

  def process_second_pattern_feedback
    create_second_pattern_variables
    store_found_colour(change_in_reds)
    adjust_patterns_for_next_guess
  end
end
