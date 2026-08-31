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
    puts "#{name}, please enter row: top/middle/bottom"
    row = gets.chomp
    puts ''
    puts 'Please enter column: left/middle/right'
    column = gets.chomp
    board.choice(row, column, self)
  end

  def self.names
    @@names
  end
end
