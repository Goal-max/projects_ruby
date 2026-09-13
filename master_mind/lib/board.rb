require_relative 'player'
require_relative 'data'

class Board
  include Info

  def initialize
    @players = { 'code_maker' => Player.new('Code Maker', self),
                 'code_breaker' => Player.new('Code Breaker', self) }
  end
end

