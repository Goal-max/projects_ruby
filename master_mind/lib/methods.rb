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

  def self.ask_player(colours_hash, text)
    loop do
      guess = self.ask_input(text)
      guess_nowhitespace = self.remove_whitespace(guess)
      input_letters = self.string_to_letters(guess_nowhitespace)
      input_letters_as_symbols = self.array_letters_to_symbols(input_letters)
      colours_keys_reference = colours_hash.keys
      invalid_letters = input_letters_as_symbols.difference(colours_keys_reference)
      if !invalid_letters.empty?
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
end
