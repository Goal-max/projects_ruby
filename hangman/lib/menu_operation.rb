class MenuOperation
  def operate(menu)
    loop do
      menu.display
      input = gets.chomp
      break input if menu.valid_input?(input)

      puts 'Invalid input'
      puts
    end
  end
end
