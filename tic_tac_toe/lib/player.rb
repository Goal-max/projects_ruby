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
    begin
      puts "#{name}'s turn."
      input = ask_input(question)
      return input if input == 'q'

      input = process_input(input)
    rescue StandardError => e
      invalid_input
      retry
    else
      input
    end
  end

  def process_input(input)
    row = format_input(input, board.class::ROWS)
    column = format_input(input, board.class::COLUMNS)
    if row && column
      board.choice(row[0], column[0], self)
    else
      invalid_input
    end
  end
erd
