class MenuOperation
  attr_accessor :menu_list

  def initialize
    @menu_list = [HashMenu.new(self)]
  end

  def operate
    loop do
      @menu = @menu_list.last
      @menu.display
      input = gets.chomp.downcase
      if @menu.valid_input?(input)
        @menu.menu_action(self)
      else
        error_message
      end
    end
  end

  def error_message
    puts 'Invalid input. Please try again'
    puts
  end
end
