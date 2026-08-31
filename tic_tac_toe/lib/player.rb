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

  def self.names
    @@names
  end
end
