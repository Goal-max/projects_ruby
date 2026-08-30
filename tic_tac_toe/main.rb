require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'

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

board = Board.new
player_one = Player.create_player('Player one')
player_two = Player.create_player('Player two')

def play_round(player_one, player_two, board)
  player_one.get_choice(board)
  search_winner
  player_two.get_choice(board)
end

binding.b

