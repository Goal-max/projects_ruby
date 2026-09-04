require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'

main_menu_items = [
  [1, 'New Game'],
  [2, 'Exit Progam']
]

def main_menu(main_menu_items)
  main_menu_items.each do |sub_item| 
    puts "#{sub_item[0]}. #{sub_item[1]}"
  end
end

main_menu(main_menu_items)

board = Board.new
player_one = Player.create_player('Player one', board)
player_two = Player.create_player('Player two', board)

def play_round(player_one, player_two, board)
  until board.search_winner
    player_one.find_choice
    break if board.search_winner

    player_two.find_choice
  end
end

play_round(player_one, player_two, board)

binding.b

