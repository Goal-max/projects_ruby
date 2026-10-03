class IndexMenu < Menu
  def hash_menu(items)
    items.each.to_h do |item|
      [item[0].to_sym, item]
    end
  end

  def menu_screen
    loop do
      super
      choice = chosen_item(input)
      break choice unless choice.nil

      puts invalid_choice
    end
  end
end
