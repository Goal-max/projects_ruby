class Menu
  attr_reader :title, :question, :menu_items, :menu_with_index, :choice

  def initialize(items, question, title = nil)
    @title = title
    @question = question
    # @menu_items = items
    @menu_with_index = indexed_menu(items)
  end

#need to refactor below hash key to symbols
  def indexed_menu(items)
    items.each_with_index.to_h do |item, index|
      [(index + 1).to_s, item]
    end
  end

  def menu_screen
    loop do
      Methods.print_text(title) unless title.nil?
      display_menu
      input = choice = Methods.ask_input(question)
      unless valid_input(input)
        puts 'Invalid choice. Please enter an integer'
      else
        choice = choice_with_item(input)
        break choice
      end
    end
  end

  def choice_with_item(input)
    { input => menu_with_index[:input] }
  end

  def display_menu
    menu_with_index.each_pair do |key, value|
      puts "#{key}. #{value}"
    end
  end

  def valid_input(input)
    menu_with_index.include?(input)
  end
end
