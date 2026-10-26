class GameMenu
  def initialize(computer)
    @computer = computer
    @previous_guesses = []
    @incorrect_guesses = []
    @guesses_remaining = 8
  end

  def display
    puts "Guesses remaining: #{@guesses_remaining}"
    puts "Incorrect letters: #{@incorrect_guesses}"
    puts @computer.answer.join(' ')
    puts 'Please guess word'
  end

  def ask_input
    loop do
      display
      @input = gets.chomp.upcase
      break if input != ''
    end
  end

  def single_letter_guess
    if correct_letter?(@input)
      computer.update_answer
    else
      incorrect_guesses << input
    end
    @guesses_remaining -= 1
  end

  def final_guess
    @guesses_remaining = 0
    if computer.correct_word?(@input)
      @win = true
    else
      puts 'Game over'
    end
  end

  def play_game
    until @guesses_remaining.zero?
      ask_input
      if @input.length == 1
        single_letter_guess
      else
        final_guess
      end
    end
  end
end
