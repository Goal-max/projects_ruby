class Menu
  attr_reader :title, :question, :menu_items, :menu_with_index,
  :invalid_choice_text
  attr_accessor :choice

  def initialize(items, question, title = nil)
    @title = title
    @question = question
    @menu_with_index = indexed_menu(items)
    @invalid_choice_text = 'Invalid choice. Please enter an integer'
  end

  def indexed_menu(items)
    items.each_with_index.to_h do |item, index|
      [(index + 1).to_s.to_sym, item]
    end
  end

  def menu_screen
    loop do
      Methods.print_text(title) unless title.nil?
      display_menu
      input = Methods.ask_input(question)
      choice = chosen_item(input)
      break choice unless choice.nil?

      puts invalid_choice_text
    end
  end

  def chosen_item(input)
    menu_with_index[input.to_sym]
  end

  def display_menu
    menu_with_index.each_pair do |key, value|
      puts "#{key}. #{value}"
    end
  end

  def valid_input(input)
    menu_with_index.include?(input.to_sym)
  end
end
