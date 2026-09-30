class Menu
  attr_reader :title, :menu_items

  def initialize(items, title = nil)
    @title = title
    @menu_items = items
  end

  def menu_screen(menu_items, question, opt = nil)
    loop do
      Methods.print_text(opt) unless opt.nil?
      self.display_menu(menu_items)
      player_role = Methods.ask_input(question)
      break player_role if valid_input?(menu_items, player_role)

      puts 'Invalid choice. Please enter an integer'
    end
  end
end
