require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/methods'
require_relative 'lib/menu'
require_relative 'lib/indexed_menu'
require_relative 'lib/hash_menu'
require_relative 'lib/patterns'
require_relative 'lib/analyse_feedback'

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
    patterns = Patterns.new(board, codepeg_colours)
    analyse_feedback = AnalyseFeedback.new(board, patterns)
  end
  12.times do
    case player_role
# guess secret code
    when 'Code Breaker'
      input = colour_menu.menu_screen
    when 'Code Maker'
      input = patterns.take_pattern
    end
    if board.guess_correct?(input)
      puts 'win'
      puts "secret code is #{input}"
      break
    else
      board.check_guess(input)
    end
    patterns.analyse_feedback if player_role == 'Code Maker'
  end
end
