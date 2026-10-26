require 'debug'
require_relative 'lib/words'
require_relative 'lib/computer'
require_relative 'lib/menu_operation'
require_relative 'lib/hash_menu'
require_relative 'lib/game_menu'

file_location = '/home/rain/Downloads/google-10000-english-no-swears.txt'
min_word_length = 5
max_word_length = 12

menu = MenuOperation.new
main_menu = HashMenu.new

input = menu.operate(main_menu)

if input == '1'
  computer = Computer.new(Words.new(file_location,
                                  min_word_length,
                                  max_word_length))
  game_menu = GameMenu.new(computer)
  game_menu.ask_input
end
