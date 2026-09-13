require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'

main_menu = [
  ['1', 'New game'],
  ['2', 'Exit program']
]

main_menu_items = main_menu.map { |item| item[0]}

def print_text(text)
  puts "\n#{text}\n"
end

def ask_input(text)
  input = ''
  while input == ''
    print_text(text)
    input = gets.chomp.strip
  end
  input
end

def check_input(reference, input)
  reference.intersection(input)
end

menu_input = ''

until menu_input == '2'
  menu_input = ''
  while menu_input == ''
    print_text('Welcome to Master Mind')
    main_menu.each do |menu_item|
      puts "#{menu_item[0]}. #{menu_item[1]}"
    end
    menu_input = ask_input('Please enter choice: ')
    redo unless main_menu_items.include?(menu_input)
    break if menu_input == '2'

    board = Board.new
  end
end
