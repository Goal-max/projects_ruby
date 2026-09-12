module ModifyString
  def remove_whitespace(string)
    string.gsub(/\s/, '')
  end

  def invalid_input
    puts 'Invalid input entered. Please try again.'
    puts ''
  end

  def ask_input(question)
    input = ''
    while input == ''
      puts question
      input = gets.chomp.strip
    end
    input
  end

  def format_input(input, reference)
    input.upcase.chars.intersection(reference)[0]
  end

  def already_occupied
    puts 'Position taken. Please try again'
  end
end
