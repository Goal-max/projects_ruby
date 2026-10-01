class Menu
  attr_reader :title, :question, :menu_items, :choice

  def initialize(items, question, title = nil)
    @title = title
    @question = question
    @menu_items = items
  end

  def menu_screen
    loop do
      Methods.print_text(title) unless title.nil?
      display_menu
      @choice = Methods.ask_input(question)
      break choice if valid_input?(menu_items, choice)

      puts 'Invalid choice. Please enter an integer'
    end
  end

  def display_menu
    menu_items.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end
  end

  def menu_item_by_number
    menu_items[choice.to_i - 1]
  end
end
