require_relative 'player'
require_relative 'methods'

class Board
  include Methods

  def initialize; end

  def generate_code(colours)
    @code = Array.new(4) { colours.sample }
  end
end
