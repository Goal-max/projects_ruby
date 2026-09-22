module Methods
  def self.print_text(text)
    puts "\n#{text}\n"
  end

  def self.ask_input(text)
    input = ''
    while input == ''
      print_text(text)
      input = gets.chomp.strip
    end
    puts ''
    input
  end

  def self.ask_player(colours_hash)
    loop do 
      guess = self.ask_input('Please guess the secret code (use one letter for each'\
      'colour e.g. rrbi)')
      guess_nowhitespace = self.remove_whitespace(guess)
      colours_keys_reference = colours_hash.keys
      input_letters = self.string_to_letters(guess_nowhitespace)
      input_letters_as_symbols = self.array_letters_to_symbols(input_letters)
      invalid_letters = input_letters_as_symbols.difference(colours_keys_reference)
      if invalid_letters.length > 0
        puts "Invalid input: #{invalid_letters.join(', ')}."
        redo
      elsif input_letters.length != 4
        puts "Invalid input: please enter 4 colours only."
        redo
      end
      input_colours = input_letters_as_symbols.map do |letter|
        colours_hash[letter]
      end
      break input_colours
    end
  end

  def self.ask_computer(guesses_and_feedback, codepeg_colours)
    first_index_of_pair = [0, 2, 4]
  

  end
end
