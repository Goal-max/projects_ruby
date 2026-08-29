class Player
  def initialize(name)
    @name = name
  end

  def choice(row, column)
    board.choice(row, column, name)
  end
end
