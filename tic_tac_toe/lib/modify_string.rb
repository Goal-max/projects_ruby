module ModifyString
  def remove_whitespace(string)
    string.gsub(/\s/, '')
  end

  def invalid_input
    puts 'Invalid input entered. Please try again.'
    puts ''
  end

  def ask_input(question)
    puts question
    gets.chomp.strip.upcase
  end

  def format_input(input, reference)
    input.chars.intersection(reference)[0]
  end

  def already_occupied
    puts 'Position taken. Please try again'
  end
end
