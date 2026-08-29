require 'debug'
require_relative 'lib/board'

board = Board.new
board.choice('top', 'middle', 'peter')

def check_win?(array, player_name)
  array.all?(player_name)
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

# find names at each of 3 winning positions
=begin
winning.each_value do |winning_type|
  array = []
  winning_type.each_pair do |key, column|
    array << board.board_info.dig(key, column)
  end
  puts "array is #{array}"
end
=end

winning.each_value { |value| p value }
binding.b
