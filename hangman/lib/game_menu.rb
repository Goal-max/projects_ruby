class GameMenu
  include BasicSerializable

  attr_writer :computer

  def initialize(computer = nil)
    unless computer.nil?
      @computer = computer
      @previous_guesses = []
      @incorrect_guesses = []
      @guesses_remaining = 8
      @input_actions = {
        one_character => single_letter_guess,
        multiple_characters => final_guess
      }
    end
  end

  def display
    puts "Guesses remaining: #{@guesses_remaining}"
    puts "Incorrect letters: #{@incorrect_guesses}"
    puts @computer.answer.join(' ')
    puts "Please guess word or enter 'save' to save"
  end

  def already_guessed?
    @previous_guesses.include?(@input)
  end

  def ask_input
    loop do
      display
      @input = gets.chomp.downcase
      if already_guessed?
        puts 'Already used. Try again'
        redo
      end
      break if @input != ''
    end
  end

  def valid_input?(input)
    if input.length > @computer.answer.length
      puts 'You entered too many characters'
    else
      input.chars.all?(/[a-z]/)
    end
  end

  def single_letter_guess
    if @computer.correct_letter?(@input)
      @computer.update_answer(@input)
    else
      @incorrect_guesses << @input
    end
    @guesses_remaining -= 1
  end

  def final_guess
    @guesses_remaining = 0
    if @computer.correct_word?(@input)
      @win = true
    else
      puts 'Game over'
    end
  end

  def input_actions(input)
    {
      one_character => :single_letter_guess,
      multiple_characters => :final_guess
    }
  end

  def handle_input(input)
    self.send@input_actions[input]
  end

  def play_game
    until @guesses_remaining.zero?
      ask_input
      break 'save' if @input == 'save'

      @previous_guesses << @input
      if @input.length == 1
        single_letter_guess
      else
        final_guess
      end
    end
  end
end
