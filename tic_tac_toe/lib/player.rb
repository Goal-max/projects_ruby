require_relative 'modify_string'

class Player
  include ModifyString

  attr_reader :name, :board

  @@names = []
  def initialize(name, board)
    @name = name
    @@names << name
    @board = board
    self
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
    if input.nil?
      find_choice
    else
      process_input(input)
    end
  end

  def input
    input = gets.chomp.strip
    input = remove_whitespace(input)
    if input.empty?
      puts 'Invalid input entered. Please try again.'
    else
      input
    end
  end
  
  def process_input(input)
    find_choice unless input.length == 2
    row = find_row(input)
    column = find_column(input)
    board.choice(row, column, self) if row && column
  end

  def check_input(input)
    upcased_input = input.upcase
    input_array[0].match(/[A-Z]/)
    input_array[1].match(/\d/)
  end

  def self.names
    @@names
  end
end
