class MenuOperation
  def operate
    loop do
      @current_menu.display
      input = gets.chomp
      break input if @current_menu.valid_input?(input)

      puts 'Invalid input'
      puts
    end
  end
end
