class Player
  @@names = []
  def initialize(name)
    @name = name
    @@names << name
  end

  def choice(row, column)
    board.choice(row, column, name)
  end

  def self.names
    @@names
  end
end
