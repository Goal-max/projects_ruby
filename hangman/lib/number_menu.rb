class NumberMenu
  attr_reader :hash_menu

  def initialize
    @menu_items = ['New Game', 'Load Game']
    @hash_menu = create_hash_menu
  end

  def create_hash_menu
    hash = {}
    @menu_items.each_with_index do |item, index|
      hash[(index + 1).to_s] = item
    end
    hash
  end

  def display
    hash_menu.each_pair do |key, value|
      puts "#{key}. #{value}"
    end
  end

  def valid_input?(input)
    hash_menu.key?(input)
  end
end
