require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/methods'

def display_menu(menu_items)
  menu_items.each_with_index do |item, index|
    puts "#{index + 1}. #{item}"
  end
end

def menu_indices(menu_items)
  menu_items.each_index.map { |index| index + 1 }
end

def indexed_menu(items)
  items.each_with_index.map do |item, index|
    ["'#{index}'", item]
  end
end

main_menu_items = %w(New\ Game Exit\ Program)

role_menu_items = %w(Code\ Maker Code\ Breaker)

codepeg_colours = %w(red orange green yellow blue violet)

def valid_input?(menu_items, input)
  menu_indices(menu_items).include?(input.to_i)
end

def menu_item_by_number(menu_items, number)
  menu_items[number.to_i - 1]
end

def print_text(text)
  puts "\n#{text}\n"
end

def ask_input(text)
  input = ''
  while input == ''
    print_text(text)
    input = gets.chomp.strip
  end
  puts ''
  input
end

def role_screen(menu_items)
  loop do
    self.display_menu(menu_items)
    player_role = self.ask_input('Please choose your role: ')
    unless valid_input?(menu_items, player_role)
      puts 'Invalid choice. Please try again'
      redo
    end
    break
  end
end

def print_colours(codepeg_colours)
  print_text('The colours are:')
  codepeg_colours
end

def colours_hash(codepeg_colours)
  codepeg_colours.to_h { |colour| [colour[0], colour] }
end

menu_input = ''

until menu_input == '2'
  menu_input = ''
  while menu_input == ''
    print_text('Welcome to Master Mind')
    display_menu(main_menu_items)
    menu_input = ask_input('Please enter choice: ')
    unless valid_input?(main_menu_items, menu_input)
      puts 'Invalid choice. Please enter an integer.'
      redo
    end
    break if menu_input == '2'

    role_menu_number = role_screen(role_menu_items)
    player_role = menu_item_by_number(role_menu_items, role_menu_number)

    board = Board.new
    if player_role == 'Code Breaker'
      board.generate_code(codepeg_colours)
      print_text('The four colour secret code has been generated')
      print_colours(codepeg_colours)
      guess = ask_input('Please guess the secret code')
    end
    code_maker = board.players['code_maker']
    12.times do
    end  
  end
end
