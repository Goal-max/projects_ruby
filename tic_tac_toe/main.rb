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

board = Board.new

def play_round(player_one, player_two, board)
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
  board.display_menu(main_menu_items)
  input = board.main_menu(menu_numbers)[0]
  next if input == '2'

  puts
  player_one = Player.new('Player one', board)
  player_two = Player.new('Player two', board)
  play_round(player_one, player_two, board)
  puts ''
end
