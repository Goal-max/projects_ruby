require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/methods'
require_relative 'lib/computer_code_breaker'
require_relative 'lib/menu'
require_relative 'lib/indexed_menu'
require_relative 'lib/hash_menu'

def menu_indices(menu_items)
  menu_items.each_index.map { |index| index + 1 }
end

main_menu_items = ['New Game', 'Exit Program']
main_menu_title = 'Welcome to Master Mind'
main_menu_question = 'Please enter choice:'
main_menu = IndexMenu.new(main_menu_items, main_menu_question, main_menu_title)

role_menu_items = ['Code Maker', 'Code Breaker']
role_question = 'Please choose your role'
role_menu = IndexMenu.new(role_menu_items, role_question)

codepeg_colours = %w[red orange green yellow blue violet]

loop do 
  menu_input = main_menu.menu_screen
  break if menu_input == 'Exit Program'

  player_role = role_menu.menu_screen
  colour_menu = HashMenu.new(codepeg_colours, player_role)
  board = Board.new
# create secret code 
  case player_role
  when 'Code Breaker'
    board.generate_code(codepeg_colours)
    text1 = 'The four colour secret code has been generated.'
    Methods.print_text(text1)
  when 'Code Maker'
    board.secret_code = colour_menu.menu_screen
    puts "Secret code is: #{board.secret_code}"
    computer = Computer.new(board, codepeg_colours)
  end
  12.times do |count|
    case player_role
# guess secret code
    when 'Code Breaker'
      input = colour_menu.menu_screen
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
#computer creates second patterns if it has not been created yet
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
      base_pattern_total_red_white =
        computer.base_pattern_feedback[:total_red_white]
      base_pattern_reds = computer.base_pattern_feedback[:red]
      base_pattern_whites = computer.base_pattern_feedback[:white]
      last_feedback_reds = last_feedback[:red]
      change_in_reds = last_feedback_reds - base_pattern_reds
#store colour worked out
      case change_in_reds
      when -1
        computer.secret_code_guess[secretcode_position_index] =
          computer.base_patterns[0][secretcode_position_index]
      when 1
        computer.secret_code_guess[secretcode_position_index] =
          computer.second_patterns[0][1][secretcode_position_index]
      end
      computer.second_pattern_total_reds_found += 1 if change_in_reds != 0
# reset pattern if found 1 red/white
      if computer.second_pattern_total_reds_found ==
         base_pattern_total_red_white &&
         base_pattern_reds != 2 &&
         base_pattern_whites != 2
        computer.clear_patterns
#reset if last second pattern guessed
      elsif computer.second_patterns.length == 1
        computer.clear_patterns
      else
        computer.second_patterns.shift
      end
    end
  end
end
