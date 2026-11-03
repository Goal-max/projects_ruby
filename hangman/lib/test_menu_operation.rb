class MenuOperation
  def initialize
    @menu_list = [HashMenu.new]
  end

  def operate
    loop do
      @menu = menu_list.last
      @menu.display
      input = gets.chomp
      if @menu.valid_input?(input)
        @menu = @menu.menu_action
        binding.b
      else
        puts 'Invalid input. Please try again'
        puts
      end
    end
  end
end
