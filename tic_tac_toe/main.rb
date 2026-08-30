require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'

board = Board.new
board.choice('top', 'left', 'peter')
board.choice('top', 'middle', 'peter')
board.choice('top', 'right', 'peter')

def win?(array)
  array.all?(array[0]) && !array[0].nil?
end

def straight_wins(position1, position2)
  position1.map do |first|
    position2.map do |second|
      { first => second }
    end
  end
end

def diagonal_wins(rows, columns)
  rows.each_with_index.map do |element, index|
    { rows[index] => columns[index] }
  end
end

rows = %w[top middle bottom]
columns = %w[left middle right]

winning = {
  'horizontal_wins' => straight_wins(rows, columns),
  'vertical_wins' => straight_wins(columns, rows),
  'diagonal_wins' => [diagonal_wins(rows, columns),
                      diagonal_wins(rows, columns.reverse)]
}

# find names at winning positions
def search_winner(winning, board)
  winner = nil
  winning.each_value do |winning_type|
    winning_type.each do |win_option|
      array_of_names = board.find_name(win_option)
      binding.b
      winner = array_of_names[0] if win?(array_of_names)
      reak if winner
    end
    break if winner
  end
  winner
end

def ask_name(player)
  puts "#{player} please enter your name:"
end

board = Board.new
ask_name('player one')
player_one = Player.new(gets.chomp)
puts "Player one is #{player_one}" 

ask_name('player two')
player_two = Player.new(gets.chomp)
puts "Player two is #{player_two}"

binding.b

