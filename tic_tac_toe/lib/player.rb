require_relative 'modify_string'

class Player
  include ModifyString

  attr_reader :name, :board

  def initialize(player, board)
    question = 'please enter your name:'
    @name = ask_input(question)
    puts "#{player} is #{name}"
    puts ''
    @board = board
    board.players << self
  end

  def find_choice
    board.display
    puts "#{name}, please enter row and column e.g. A2"
    input = ask_input
    if input.nil?
      invalid_input
      find_choice
    elsif input.upcase == 'q'
    else
      result = process_input(input)
      find_choice if result.nil?
    end
  end

  def find_choice_updated
    board.display
    question = 'please enter row and column e.g. A2'
    input = nil
    until input
      puts "#{name}'s turn."
      input = ask_input(question)
      return input if input == 'Q'

      input = process_input(input)
    end
  end

  def process_input(input)
    row = format_input(input, board.class::ROWS)
    column = format_input(input, board.class::COLUMNS)
    if row && column && board.position_taken?(row, column)
      board.assign_position(row, column, self)
    else
      already_occupied
    end
  end
end
