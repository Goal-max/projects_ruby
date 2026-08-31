require 'debug'
require_relative 'lib/board'
require_relative 'lib/player'

board = Board.new
board.display
board.board_info['top']['left'] = 'Tom'
board.board_info['middle']['left'] = 'Tom'
board.board_info['bottom']['left'] = 'Tom'
board.search_winner
binding.b


player_one = Player.create_player('Player one')
player_two = Player.create_player('Player two')

def play_round(player_one, player_two, board)
  until board.search_winner
    player_one.get_choice(board)
    break if board.search_winner

    player_two.get_choice(board)
  end
end

play_round(player_one, player_two, board)

binding.b

