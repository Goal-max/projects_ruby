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
    result = input.chars.intersection(reference)
    if result == []
      nil
    else
      result
    end
  end

  def find_row(string)
    string.upcase.match(/[A-Z]/)[0]
  end

  def find_column(string)
    match = string.match(/\d/)
    match[0] if match
  end
end

