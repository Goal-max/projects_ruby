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
  player_role = ''
  loop do
    self.display_menu(menu_items)
    player_role = self.ask_input('Please choose your role: ')
    unless valid_input?(menu_items, player_role)
      puts 'Invalid choice. Please try again'
      redo
    end
    break
  end
  player_role
end

def to_hash_with_letter_key(codepeg_colours)
  codepeg_colours.to_h { |colour| [colour[0].to_sym, colour] }
end

def print_hash_menu(hash)
  hash.each_pair do |key, value|
    puts "#{key} = #{value}"
  end
end

def remove_whitespace(string)
  string.downcase.gsub(/\s/, '')
end

def string_to_letters(string)
  string.split('')
end

def array_letters_to_symbols(array)
  array.map(&:to_sym)
end

menu_input = ''

colours_hash = to_hash_with_letter_key(codepeg_colours)
puts colours_hash
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
      print_text('Use below reference to enter the letter for each colour.')
      print_hash_menu(colours_hash)
      12.times do
        guess = ask_input('Please guess the secret code (use one letter for each'\
        'colour e.g. rrbi)')
        guess_nowhitespace = remove_whitespace(guess)
        colours_keys_reference = colours_hash.keys
        input_letters = string_to_letters(guess_nowhitespace)
        input_letters_as_symbols = array_letters_to_symbols(input_letters)
        invalid_input = input_letters_as_symbols.difference(colours_keys_reference)
        if invalid_input.length > 0
          puts "Invalid input: #{invalid_input.join(', ')}."
          redo
        elsif input_letters.length == 4
          input_colours = input_letters_as_symbols.map do |letter|
            colours_hash[letter]
          end
          if board.guess_correct?(input_colours)
            puts 'win'
          else
            board.check_input(input_colours)
            print_text('incorrect guess')
            board.list_guesses_and_feedback
          end
        end
      end
    elsif player_role == 'Code Maker'
      puts 'you are code maker'
    end
  end
end
