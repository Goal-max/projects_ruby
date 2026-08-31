require_relative 'modify_string'

class Player
  attr_reader :name

  @@names = []
  def initialize(name)
    @name = name
    @@names << name
  end

  def self.create_player(player)
    puts "#{player}, please enter your name:"
    name = gets.chomp
    puts "#{player} is #{name}"
    puts ''
    Player.new(name)
  end

  def get_choice(board)
    board.display
    puts "#{name}, please enter row: A, B, C"
    row = gets.chomp.strip
    puts ''
    puts 'Please enter column: 1, 2, 3'
    column = gets.chomp.strip
    board.choice(row, column, self)
  end

  def check_input(input)
    upcased_input = input.upcase
    input_array[0].match(/[A-Z]/)
    input_array[1].match(/\d/)
  end

  def remove_whitespace
    
  end

  def self.names
    @@names
  end
end
