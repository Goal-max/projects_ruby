class SaveGame
  def save_game(menu_operate)
    @menu_operate = menu_operate
    game_menu = @menu_operate.menu_list.pop
    binding.b
    saved_game_menu = game_menu.serialize
    game_file = File.open('saved_game_menu.txt', 'w')
  end
end
