require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/methods'
require_relative 'lib/computer_code_breaker'

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

colours_hash = to_hash_with_letter_key(codepeg_colours)


menu_input = ''
until menu_input == '2'
  menu_input = ''
  while menu_input == ''
    Methods.print_text('Welcome to Master Mind')
    display_menu(main_menu_items)
    #menu_input = ask_input('Please enter choice: ')
    menu_input = 1
    unless valid_input?(main_menu_items, menu_input)
      puts 'Invalid choice. Please enter an integer.'
      redo
    end
    break if menu_input == '2'

    #role_menu_number = role_screen(role_menu_items)
    role_menu_number = 1
    player_role = menu_item_by_number(role_menu_items, role_menu_number)
    board = Board.new
    case player_role
    when 'Code Breaker'
      board.generate_code(codepeg_colours)
      Methods.print_text('The four colour secret code has been generated')
      Methods.print_text('Use below reference to enter the letter for each colour.')
      print_hash_menu(colours_hash)
    when 'Code Maker'
      Methods.print_text('Use below reference to enter the letter for each colour.')
      print_hash_menu(colours_hash)
      text = 'Please enter four colour secret code using one letter for each'\
            'colour e.g. rrbi'
      board.secret_code = Methods.ask_player(colours_hash, text)
      puts "Secret code is: #{board.secret_code}"
      computer = Computer.new(board, codepeg_colours)
    end
    12.times do |count|
      case player_role
      when 'Code Breaker'
        text = 'Please guess the secret code (use one letter for each'\
              'colour e.g. rrbi)'
        input = Methods.ask_player(colours_hash, text)
      when 'Code Maker'
        input = computer.take_pattern
      end
      if board.guess_correct?(input)
        puts 'win'
        break
      else
        board.check_guess(input)
      end
      next if player_role == 'Code Breaker'
      feedback = board.guesses_and_feedback[count][1]
      previous_feedback = board.guesses_and_feedback[count - 1][1]
      total_red_whites = feedback.each_value.inject { |sum, value| sum + value }
      if computer.pattern_group2.empty?
        if total_red_whites == 0
          computer.incorrect_colours << computer.remove_pattern.uniq!
        elsif total_red_whites > 0 
          computer.create_second_pattern(computer.colour_patterns[0][1])
        end
      else 
        case previous_feedback[:red]
        when 1
          if feedback[:red] == 0 && feedback[:white] == 1
        when 2
        when 3
        end
      end
      binding.b
    end
  end
end
