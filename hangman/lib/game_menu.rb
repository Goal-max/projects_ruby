class GameMenu
  def initialize(computer)
    @answer = computer.answer
  end

  def display
    puts @answer.join(' ')
    puts 'Please guess word'
  end

  def ask_input
    loop do
      display
      input = gets.chomp.upcase
      break input if input != ''
    end
  end
end
