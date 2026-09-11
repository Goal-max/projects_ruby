require_relative 'modify_string'

class Player
  include ModifyString

  attr_reader :name, :board

  def initialize(player, board)
    question = 'please enter your name:'
    @name = ask_input("#{player}, #{question}")
    puts "#{player} is #{name}"
    puts ''
    @board = board
    board.players << self
  end

  def find_choice
    board.display
    question = 'please enter row and column e.g. A2. Q = quit'
    input = nil
    until input
      input = ask_input("#{name}, #{question}").upcase
      input = board.confirm_quit if input == 'Q'
      return input if input == 'Q'
      next if input.nil?

      input = process_input(input)
    end
  end

  def process_input(input)
    row = format_input(input, board.class::ROWS)
    column = format_input(input, board.class::COLUMNS)
    if board.position_taken?(row, column)
      already_occupied
    elsif row && column
      board.assign_position(row, column, self)
    else
      invalid_input
    end
  end
end
