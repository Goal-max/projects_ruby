module ModifyString
  def remove_whitespace(string)
    string.gsub(/\s/, '')
  end

  def invalid_input
    puts 'Invalid input entered. Please try again.'
  end

  def ask_input
    input = gets.chomp.strip
    input = remove_whitespace(input)
    if input.empty?
      invalid_input
    else
      input
    end
  end

  def compare_array(input, reference)
    result = input.upcase.chars.intersection(reference)
    if result == []
      nil
    else
      result
    end
  end

end

