require 'debug'
require_relative 'lib/board'

board = Board.new
board.choice('top', 'middle', 'peter')


rows = %w[top middle bottom]
columns = %w[left middle right]

winning = {
  horizontal_wins => straight_wins(rows, columns),
  vertical_wins => straight_wins(columns, rows),
  # diagonal wins
  diagonal_wins => [diagonal_wins(rows, columns),
  diagonal_wins(rows, columns.reverse)]
}

# find names at each of 3 winning positions
winning.each_pair do |key, value|
  array = []
  value.map do |column|
    array << board.board_info.dig(key, column)
  end
  puts "array is #{array}"
end

def check_win?(array, player_name)
  array.all?(player_name)
end

def straight_wins(position1, position2)
  hash = {}
  position1.each do |element|
    hash[element] = position2
  end
  hash
end

def diagonal_wins(rows, columns)
  hash = {}
  # array_indices = [0, 1, 2]
  # column_indices = [[array_indices], [array_indices.reverse]]
  rows.each_index do |index|
   # column_indices.each_index do |outer_array|
    #  outer_array.each_index do |column_index|
    hash[rows[index]] = columns[index]
  end
  hash
end

def 
binding.b
