class IndexMenu < Menu
  attr_reader :menu, :choice

  def initialize(items, question, title = nil)
    super(question, title)
    @menu = indexed_menu(items)
    @invalid_choice_text = 'Invalid choice. Please enter an integer'
  end

  def indexed_menu(items)
    items.each_with_index.to_h do |item, index|
      [(index + 1).to_s.to_sym, item]
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

  def display_menu
    @menu.each_pair do |key, value|
      puts "#{key}. #{value}"
    end
  end
end
