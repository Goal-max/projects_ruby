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
    if player_role == 'Code Breaker'
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

  def input_errors?(formatted_input)
    incorrect_input = formatted_input.difference(menu.keys)
    correct_length = formatted_input.length == 4
    if !incorrect_input.empty?
      puts "Invalid input: #{incorrect_input.join(', ')}."
    elsif !correct_length
      puts 'Invalid input: please enter 4 colours only.'
    end
    incorrect_input || correct_length
  end

  def letters_to_colours(letters)
    letters.map do |letter|
      menu[letter]
    end
  end

  def menu_screen
    loop do
      input = super
      binding.b
      formatted_input = formatting_methods.inject(input) do |result, method|
        send(method, result)
      end
      redo if input_errors?(formatted_input)
      input_colours = letters_to_colours(formatted_input)
      break input_colours
    end
  end
end
