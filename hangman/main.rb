require 'debug'
require_relative 'lib/basic_serializable'
require_relative 'lib/words'
require_relative 'lib/computer'
require_relative 'lib/menu_operation'
require_relative 'lib/hash_menu'
require_relative 'lib/game_menu'
require_relative 'lib/serialize_processor'
require_relative 'lib/quit_game'
require_relative 'lib/save_game'

menu = MenuOperation.new

menu.operate

if input == '1'
  computer = Computer.new(Words.new(file_location,
                                min_word_length,
                                max_word_length))
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
