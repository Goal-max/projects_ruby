require 'debug'
require_relative 'lib/board'

board = Board.new
board.choice('top', 'middle', 'peter')

def win?(array)
  array.all?(array[0])
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
  winning.each_value do |winning_type|
    winning_type.each do |win_option|
      array_of_names = []
      win_option.each do |position|
        position.each_pair do |row, column|
          array_of_names << board.board_info.dig(row, column)
        end
      end
      win?(array_of_names)
      puts "array is #{array_of_names}"
    end
  end
end

def find_names(position)
  position.each_pair do |row, column|
    board.board_info.dig(row, column)
  end
end

search_winner(winning, board)

binding.b
