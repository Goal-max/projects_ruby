require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'

main_menu = [
  ['1', 'New game'],
  ['2', 'Exit program']
]

main_menu_input = 1

while main_menu_input == 1
  board = Board.new
  main_menu.each do |menu_item|
    puts "#{menu_item[0]} #{menu_item[1]}"
  end
  main_menu_input = ask_input
  break if input == 2

end
