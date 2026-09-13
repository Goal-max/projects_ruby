module Info
  def self.print_hi
    print 'hi'
  end

  def self.ask_input(text)
    print_hi
    input = ''
    while input == ''
      print_text(text)
      input = gets.chomp.strip
    end
    input
  end
end
