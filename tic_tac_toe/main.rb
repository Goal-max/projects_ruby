require 'debug'
require_relative 'lib/board'

board = Board.new
board.choice('top', 'middle', 'peter')

winning = {
  'top' => %w[left middle right]
}

# find names at each of 3 winning positions
winning.each_pair do |key, value|
  array = []
  value.map do |column|
    array << board.board_info.dig(key, column)
  end
  puts "array is #{array}"
end

binding.b
