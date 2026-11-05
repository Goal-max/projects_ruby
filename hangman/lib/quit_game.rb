class QuitGame
  def display
    puts 'Are you sure you want to quit? (y = yes, n = no)'
  end

  def valid_input?(input)
    @input = input
    @input == 'y' || @input == 'n'
  end

  def menu_action(menu_operate)
    @menu_operate = menu_operate
    @menu_operate.menu_list.pop
    SaveGame.new.save_game(@menu_operate) if @input == 'y'
  end
end
