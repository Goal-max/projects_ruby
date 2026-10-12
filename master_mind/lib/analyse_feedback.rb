class AnalyseFeedback
  attr_reader :board,
              :patterns

=begin
  attr_accessor :last_feedback,
                :base_pattern_feedback,
                :secretcode_position_index, 
                :base_pattern_total_red_white,
                :base_pattern_whites,
                :second_pattern_total_reds_found
=end                

  def initialize(board, patterns)
    @board = board
    @patterns = patterns
    @last_feedback = nil
  end

  def analyse_feedback
    if patterns.second_patterns.empty?
      process_base_pattern_feedback
    else
      process_second_pattern_feedback
    end
  end

  def assign_base_variables
    @base_pattern_feedback = board.guesses_and_feedback[-1][1]
    @base_pattern_total_red_white = base_pattern_feedback[:total_red_white]
    @base_pattern_reds = base_pattern_feedback[:red]
    @base_pattern_whites = base_pattern_feedback[:white]
    @second_pattern_total_reds_found = nil
  end

  def process_base_pattern_feedback
    assign_base_variables
    if base_pattern_total_red_white == 0
      patterns.base_patterns.shift
    else
      patterns.create_second_pattern(patterns.colours_paired[0])
    end
    patterns.colours_paired.shift
  end
  
  def create_second_pattern_variables
    @secretcode_position_index = patterns.second_patterns[0][0]
    @last_feedback = board.guesses_and_feedback[-1][1]
  end

  def change_in_reds
    base_pattern_reds = patterns.base_pattern_feedback[:red]
    last_feedback_reds = last_feedback[:red]
    last_feedback_reds - base_pattern_reds
  end

  def store_colour(change_in_reds)
    case change_in_reds
    when -1
      copy_base_colour_to_code
    when 1
      copy_guess_colour_to_code
    end
    @second_pattern_total_reds_found += 1 if change_in_reds != 0
  end

  def copy_base_colour_to_code
    patterns.secret_code_guess[@secretcode_position_index] =
      patterns.base_patterns[0][@secretcode_position_index]
  end

  def copy_guess_colour_to_code
    patterns.secret_code_guess[@secretcode_position_index] =
      patterns.second_patterns[0][1][@secretcode_position_index]
  end

  def adjust_patterns_for_next_guess
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

  def process_second_pattern_feedback
    create_second_pattern_variables
    store_colour(change_in_reds)
    adjust_patterns_for_next_guess
  end
end
