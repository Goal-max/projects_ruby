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

  def find_name(position)
    position.each_pair do |row, column|
      return board_info.dig(row, column)
    end
  end
end
