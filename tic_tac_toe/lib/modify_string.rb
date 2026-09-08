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
    gets.chomp.strip
  end

  def format_input(input, reference)
    result = input.upcase.chars.intersection(reference)
    if result == []
      nil
    else
      result
    end
  end

end

