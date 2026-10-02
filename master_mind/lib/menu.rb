class Menu
  attr_reader :title, :question, :menu_items, :menu_with_index, :choice

  def initialize(items, question, title = nil)
    @title = title
    @question = question
    @menu_items = items
    @menu_with_index = indexed_menu(items)
  end

  def menu_screen
    loop do
      Methods.print_text(title) unless title.nil?
      display_menu
      @choice = Methods.ask_input(question)
      break choice if valid_input(menu_with_index, choice)

      puts 'Invalid choice. Please enter an integer'
    end
  end

  def display_menu
    menu_items.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end
  end

  def indexed_menu(items)
    items.each_with_index.to_h do |item, index|
      [(index + 1).to_s, item]
    end
  end

  def valid_input_test(indexed_menu, input)
    indexed_menu.include?(input)
  end
end
