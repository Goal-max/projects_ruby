class Board
  attr_reader :board_info, :players

  WINNING = {
    'horizontal_wins' => straight_wins(rows, columns),
    'vertical_wins' => straight_wins(columns, rows),
    'diagonal_wins' => [diagonal_wins(rows, columns),
                        diagonal_wins(rows, columns.reverse)]
  }

  def initialize
    @board_info = { 'top' => {}, 'middle' => {}, 'bottom' => {} }
    @players = []
  end

  def choice(row, column, player_name)
    if @board_info[row][column].nil?
      @board_info[row][column] = player_name
    else
      puts 'Position taken. Please try again'
    end
  end

  def find_name(win_option)
    array = []
    win_option.map do |position|
      position.each_pair do |row, column|
        array << board_info.dig(row, column)
      end
    end
    array
  end

  # find names at winning positions
  def search_winner(winning, board)
    winner = nil
    winning.each_value do |winning_type|
      winning_type.each do |win_option|
        array_of_names = board.find_name(win_option)
        winner = array_of_names[0] if win?(array_of_names)
        break if winner
      end
      break if winner
    end
    winner
  end

end
