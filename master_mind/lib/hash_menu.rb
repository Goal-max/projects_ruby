class HashMenu < Menu
  attr_reader :menu, :choice

  def initialize(items, question, title = nil)
    super(question, title)
    @menu = hash_menu(items)
  end

  def hash_menu(items)
    items.each.to_h do |item|
      [item[0].to_sym, item]
    end
  end

  def menu_screen
    loop do 
      input = super
      @choice = chosen_item(input)
      break choice unless choice.nil?

      puts invalid_choice
    end
  end
end
