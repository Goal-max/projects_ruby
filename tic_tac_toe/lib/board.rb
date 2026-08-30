class Board
  attr_reader :board_info, :players

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
end
