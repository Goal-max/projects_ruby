class Board
  attr_reader :board_info

  def initialize
    @board_info = { 'top' => {}, 'middle' => {}, 'bottom' => {} }
  end

  def choice(row, column, player_name)
    if @board_info[row][column].nil?
      @board_info[row][column] = player_name
    else
      puts 'Position taken. Please try again'
    end
  end
end
