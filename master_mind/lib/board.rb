require_relative 'player'
require_relative 'data'

class Board
  include Info

  def initialize
    @players = []
  end

end

