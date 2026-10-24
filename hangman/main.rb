require_relative 'lib/words'
require_relative 'lib/computer'
require_relative 'lib/menu_operation'
require_relative 'lib/number_menu'

file_location = '/home/rain/Downloads/google-10000-english-no-swears.txt'
min_word_length = 5
max_word_length = 12

computer = Computer.new(Words.new(file_location,
                                  min_word_length,
                                  max_word_length))
menu = MenuOperation.new
main_menu = NumberMenu.new

menu.operate(main_menu)
