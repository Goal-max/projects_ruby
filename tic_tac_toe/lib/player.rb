class Player
  def initialize(name)
    @name = name
  end

  def choice(row, column)
    board.send [column] = name
  end
end
