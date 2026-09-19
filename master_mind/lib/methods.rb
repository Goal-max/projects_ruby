module Methods
  def self.ask_input(text)
    print_hi
    input = ''
    while input == ''
      print_text(text)
      input = gets.chomp.strip
    end
    input
  end

  def self.add_one(num)
    add_two(num)
  end

  def self.add_two(num)
    num + 2
  end
end
