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

main_menu_items = %w[New\ Game Exit\ Program]

role_menu_items = %w(Code\ Maker Code\ Breaker)

codepeg_colours = %w(red orange green yellow blue violet)

def valid_input?(menu_items, input)
  menu_indices(menu_items).include?(input.to_i)
end

def menu_item_by_number(menu_items, number)
  menu_items[number.to_i - 1]
end

def menu_screen(menu_items, question, opt = nil)
  loop do
    Methods.print_text(opt) unless opt.nil?
    self.display_menu(menu_items)
    player_role = Methods.ask_input(question)
    break player_role if valid_input?(menu_items, player_role)

    puts 'Invalid choice. Please enter an integer'
  end
end

def menu_screen_test(menu_items, question)
  self.display_menu(menu_items)
  player_role = Methods.ask_input(question)
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

loop do 
  title = 'Welcome to Master Mind'
# find menu_choice
  question = 'Please enter choice:'
  menu_input = menu_screen(main_menu_items, question, title)
  break if menu_input == '2'

#role_menu_input = 1
  question = 'Please choose your role'
  role_menu_input = menu_screen(role_menu_items, question)
  player_role = menu_item_by_number(role_menu_items, role_menu_input)
  board = Board.new
  text_reference = 'Use below reference to enter the letter for each colour.'
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
    text = 'Please enter four colour secret code using one letter for each'\
          'colour e.g. rrbi'
    board.secret_code = Methods.ask_player(colours_hash, text)
    puts "Secret code is: #{board.secret_code}"
    computer = Computer.new(board, codepeg_colours)
  end
  12.times do |count|
    case player_role
# find player input
    when 'Code Breaker'
      text = 'Please guess the secret code (use one letter for each'\
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
