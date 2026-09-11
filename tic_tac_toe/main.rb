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
  until winner
    board.players.each do |player|
      winner = board.search_winner
      break if winner

      player.find_choice
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
