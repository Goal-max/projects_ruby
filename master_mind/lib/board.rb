require_relative 'player'
require_relative 'methods'

class Board
  include Methods

  def initialize
    @players = { 'code_maker' => Player.new('Code Maker', self),
                 'code_breaker' => Player.new('Code Breaker', self) }
  end

  def generate_code(colours)
    @code = Array.new(4) { colours.sample }
  end
end
