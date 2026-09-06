require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/modify_string'

main_menu_items = [
  [1, 'New Game'],
  [2, 'Exit Progam']
]

def main_menu(main_menu_items)
  main_menu_items.each do |sub_item| 
    puts "#{sub_item[0]}. #{sub_item[1]}"
  end
end

def menu
  main_menu(main_menu_items)
  ask_input
end

menu

board = Board.new
player_one = Player.new('Player one', board)
player_two = Player.new('Player two', board)

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

play_round(player_one, player_two, board)

binding.b

