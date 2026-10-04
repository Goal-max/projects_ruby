class Menu
  attr_reader :title, :question, :invalid_choice_text
  attr_accessor :choice

  def initialize(question, title)
    @title = title
    @question = question
  end

  def menu_screen
    Methods.print_text(title) unless title.nil?
    display_menu
    Methods.ask_input(question)
  end

  def chosen_item(input)
    menu[input.to_sym]
  end
end
