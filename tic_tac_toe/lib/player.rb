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
    name = gets.chomp.strip
    puts "#{player} is #{name}"
    puts ''
    new(name, board)
  end

  def get_choice
    board.display
    puts 'Please enter row and column e.g. A2'
    input = gets.chomp.strip
    if input.empty?
      puts 'No choice entered. Please try again.'
      get_choice
    else
      process_input(input)
    end
  end
  
  def process_input(input)
    binding.b
    input_trimmed = remove_whitespace(input)
    if input_trimmed.length == 2 
      row = find_row(input_trimmed)
      column = find_column(input_trimmed)
      if row && column
        board.choice(row, column, self)
      else
        get_choice
      end
    end
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
