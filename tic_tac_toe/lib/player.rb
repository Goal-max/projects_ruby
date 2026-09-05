require_relative 'modify_string'

class Player
  include ModifyString

  attr_reader :name, :board

  @@player_list = []

  def initialize(name, board)
    @name = name
    @@player_list << self
    @board = board
  end

  def self.create_player(player, board)
    puts "#{player}, please enter your name:"
    input = gets.chomp.strip
    puts "#{player} is #{input}"
    puts ''
    new(input, board)
  end

  def find_choice
    board.display
    puts 'Please enter row and column e.g. A2'
    input = ask_input
    if input.nil?
      find_choice
    else
      process_input(input)
    end
  end

  def process_input(input)
    find_choice unless input.length == 2
    row = compare_array(input, board.class::ROWS)
    column = compare_array(input, board.class::COLUMNS)
    if row && column
      board.choice(row[0], column[0], self)
    else
      invalid_input
      find_choice
    end
  end

  def self.names
    @@names
  end
end
