require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/methods'
require_relative 'lib/computer_code_breaker'
require_relative 'lib/menu'

def menu_indices(menu_items)
  menu_items.each_index.map { |index| index + 1 }
end

main_menu_items = ['New Game', 'Exit Program']
main_menu_title = 'Welcome to Master Mind'
main_menu_question = 'Please enter choice:'
main_menu = Menu.new(main_menu_items, main_menu_question, main_menu_title)

role_menu_items = ['Code Maker', 'Code Breaker']
role_question = 'Please choose your role'
role_menu = Menu.new(role_menu_items, role_question)

codepeg_colours = %w[red orange green yellow blue violet]

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

loop do 
  menu_input = main_menu.menu_screen
  break if menu_input == 'Exit Program'

#role_menu_input = 1
  player_role = role_menu.menu_screen
  board = Board.new
  text_reference = 'Use below reference to enter the letter for each colour.'
# create secret code 
  case player_role
  when 'Code Breaker'
    board.generate_code(codepeg_colours)
    text1 = 'The four colour secret code has been generated.'
    Methods.print_text(text1)
    Methods.print_text(text_reference)
    print_hash_menu(colours_hash)
  when 'Code Maker'
    Methods.print_text(text_reference)
    print_hash_menu(colours_hash)
    text = 'Please enter four colour secret code using one letter for each '\
          'colour e.g. rrbi'
    board.secret_code = Methods.ask_player(colours_hash, text)
    puts "Secret code is: #{board.secret_code}"
    computer = Computer.new(board, codepeg_colours)
  end
  12.times do |count|
    case player_role
# guess secret code
    when 'Code Breaker'
      text = 'Please guess the secret code (use one letter for each '\
            'colour e.g. rrbi)'
      input = Methods.ask_player(colours_hash, text)
    when 'Code Maker'
      input = computer.take_pattern
    end
    if board.guess_correct?(input)
      puts 'win'
      puts "secret code is #{input}"
      break
    else
      board.check_guess(input)
    end
    next if player_role == 'Code Breaker'

# computer calculates next guess
    last_feedback = board.guesses_and_feedback[count][1]
#computer creates second patterns
    if computer.second_patterns.empty?
      computer.base_pattern_feedback = last_feedback
      total_red_whites = computer.base_pattern_feedback[:total_red_white]
      if total_red_whites == 0
        computer.base_patterns.shift
      elsif total_red_whites > 0 
        computer.create_second_pattern(computer.colours_paired[0])
      end
      computer.colours_paired.shift
#computer checks for change in feedback reds
    else
      secretcode_position_index = computer.second_patterns[0][0]
      unless computer.secret_code_guess[secretcode_position_index].nil?
        computer.second_patterns.shift
        next
      end
      base_pattern_total_red_white =
        computer.base_pattern_feedback[:total_red_white]
      base_pattern_reds = computer.base_pattern_feedback[:red]
      last_feedback_reds = last_feedback[:red]
      feedback_difference = last_feedback_reds - base_pattern_reds
#store colour worked out
      case feedback_difference
      when -1
        computer.secret_code_guess[secretcode_position_index] =
          computer.base_patterns[0][secretcode_position_index]
      when 1
        computer.secret_code_guess[secretcode_position_index] =
          computer.second_patterns[0][1][secretcode_position_index]
      end
#update total reds found
      if feedback_difference != 0
        computer.second_pattern_total_reds_found += 1
      end
# reset pattern if found 1 red/white
      if base_pattern_total_red_white == 1 &&
        computer.second_pattern_total_reds_found == 1
        computer.second_pattern_total_reds_found = 0
        computer.base_patterns.shift
        computer.second_patterns = []
        next
      end
# reset pattern if base_pattern feedback has one red and one white, and 2 reds \
# found
      if computer.base_pattern_feedback[:red] == 1 &&
         computer.base_pattern_feedback[:white] == 1 &&
         computer.second_pattern_total_reds_found == 2
        computer.second_pattern_total_reds_found = 0
        computer.base_patterns.shift
        computer.second_patterns = []
        next
      end

#reset if last second pattern guessed
      if computer.second_patterns.length == 1
        computer.base_patterns.shift
        computer.second_pattern_total_reds_found = 0
      end
      computer.second_patterns.shift
    end
  menu_input = 1
  end
end
