require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'

main_menu_items = [
  '1. New game',
  '2. Exit game'
]

def main_menu(main_menu_items)
  puts main_menu_items
  board = Board.new
end

main_menu(main_menu_items)

player_one = Player.create_player('Player one', board)
player_two = Player.create_player('Player two', board)

def play_round(player_one, player_two, board)
  until board.search_winner
    player_one.get_choice
    break if board.search_winner

    player_two.get_choice
  end
end

play_round(player_one, player_two, board)

binding.b

