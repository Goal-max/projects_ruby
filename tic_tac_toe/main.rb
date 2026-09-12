require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/modify_string'

main_menu_items = [
  ['1', 'New Game'],
  ['2', 'Exit Progam']
]

menu_numbers = main_menu_items.map do |item|
  item[0]
end

def play_round(board)
  winner = nil
  input = nil
  until winner || input == 'Q'
    board.players.each do |player|
      input = player.find_choice
      input = board.confirm_quit if input == 'Q'
      winner = board.search_winner
      if winner || input == 'Q'
        board.display
        break
      end
      nil_values = []
      board.board_info.each_value do |column|
        nil_values << column.values
      end
      next if nil_values.flatten.include?(nil)

      board.display
      input = 'Q'
      puts 'Draw! Game over'
      break
    end
  end
end

input = nil
until input == '2'
  board = Board.new
  board.display_menu(main_menu_items)
  input = board.main_menu(menu_numbers)[0]
  next if input == '2'

  puts
  Player.new('Player one', board)
  Player.new('Player two', board)
  play_round(board)
  puts ''
end
