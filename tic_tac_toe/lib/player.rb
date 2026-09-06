require_relative 'modify_string'

class Player
  include ModifyString

  attr_reader :name, :board

  @@player_list = []

  def initialize(player, board)
    puts "#{player}, please enter your name:"
    @name = ask_input
    puts "#{player} is #{name}"
    puts ''
    @@player_list << self
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
    else
      result = process_input(input)
      find_choice if result.nil?
    end
  end

  def process_input(input)
    row = compare_array(input, board.class::ROWS)
    column = compare_array(input, board.class::COLUMNS)
    if row && column
      board.choice(row[0], column[0], self)
    else
      invalid_input
    end
  end

  def self.names
    @@names
  end
end
