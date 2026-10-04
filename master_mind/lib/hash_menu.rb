class HashMenu < Menu
  attr_reader :menu, :input, :formatting_methods

  def initialize(items, player_role, title = nil)
    question = create_question(player_role)
    super(question, title)
    @menu = hash_menu(items)
    @formatting_methods = %I[remove_whitespace
                             split_into_letters
                             array_letters_to_symbols]
  end

  def create_question(player_role)
    if 'Code Breaker'
      'Please guess the secret code (use one letter for each colour e.g. rrbi)'
    else
      'Please enter four colour secret code using one letter for each colour '\
      'e.g. rrbi'
    end
  end

  def hash_menu(items)
    items.each.to_h do |item|
      [item[0].to_sym, item]
    end
  end

  def display_menu
    @menu.each_pair do |key, value|
      puts "#{key} = #{value}"
    end
  end

  def remove_whitespace(string)
    string.downcase.gsub(/\s/, '')
  end

  def split_into_letters(string)
    string.split('')
  end

  def array_letters_to_symbols(array)
    array.map(&:to_sym)
  end

  def menu_screen
    loop do
      input = super
      formatted_input = formatting_methods.inject(input) do |result, method|
        send(method, result)
      end
      redo if errors?(formatted_input)
      input_colours = formatted_input.map do |letter|
        menu[letter]
      end
      break input_colours
    end
  end

  def errors?(formatted_input)
      incorrect_input = formatted_input.difference(menu.keys)
      wrong_quantity = formatted_input.length == 4
#format below to output two messages if both conditions true
      if !incorrect_input.empty?
        puts "Invalid input: #{incorrect_input.join(', ')}."
        redo
      elsif wrong_quantity
        puts 'Invalid input: please enter 4 colours only.'
        redo
      end
  end
end
