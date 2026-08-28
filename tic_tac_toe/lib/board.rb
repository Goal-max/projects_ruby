class Board
  attr_accessor :top, :middle, :bottom

  def initialize
    @top = []
    @middle = []
    @bottom = []
  end

  def choice(row, column, player)
    position = send row
    if position[column].nil?
      position[column] = player
    else
      puts 'Position taken. Please try again'
    end
  end
end
