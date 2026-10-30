require 'debug'
require_relative 'lib/basic_serializable'
require_relative 'lib/words'
require_relative 'lib/computer'
require_relative 'lib/menu_operation'
require_relative 'lib/hash_menu'
require_relative 'lib/game_menu'
require_relative 'lib/serialize_processor'

file_location = '/home/rain/Downloads/google-10000-english-no-swears.txt'
min_word_length = 5
max_word_length = 12

menu = MenuOperation.new
main_menu = HashMenu.new

input = menu.operate(main_menu)
computer = Computer.new(Words.new(file_location,
                                min_word_length,
                                max_word_length))

if input == '1'
  game_menu = GameMenu.new(computer)
else
  game_menu = GameMenu.new
  game_loaded = File.open('saved_game_menu.txt', 'r').gets
  game_menu.unserialize(game_loaded)
end
game_menu.play_game
saved_game_menu = game_menu.serialize
game_file = File.open('saved_game_menu.txt', 'w')
game_file.puts saved_game_menu
saved_computer = computer.serialize
computer_file = File.open('saved_computer.txt', 'w')
computer_file.puts saved_computer
