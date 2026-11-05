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
        :one_character => :single_letter_guess,
        :multiple_characters => :final_guess
      }
    end
  end

  def display
    puts "Guesses remaining: #{@guesses_remaining}"
    puts "Incorrect letters: #{@incorrect_guesses}"
    puts @computer.answer.join(' ')
    puts "Please guess word or enter 'quit' to quit"
  end

  def already_guessed?
    @previous_guesses.include?(@input)
  end

  def valid_input?(input)
    @input = input
    if already_guessed?
      puts 'Already used. Try again'
    elsif @input.length > @computer.answer.length
      puts 'You entered too many characters'
    elsif @input.length.zero?
      puts 'No input entered'
    else
      @input.chars.all?(/[a-z]/)
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
      puts 'You win'
      @win = true
    else
      puts 'Game over'
      @computer.reveal_word
    end
  end

  def handle_input
    if @guesses_remaining == 1
      final_guess
    elsif @input == 'quit'
      @menu_operate.add_menu(QuitGame.new)
    else
      input_type = if @input.length == 1
                    :one_character
                    else
                      :multiple_characters
                    end
      send(@input_actions[input_type])
    end
  end

  def menu_action(menu_operate)
    @menu_operate = menu_operate
    @previous_guesses << @input unless @input == 'quit'
    handle_input
    @menu_operate.menu_list.pop if @guesses_remaining.zero?
=begin
    until @guesses_remaining.zero?
      ask_input
      break 'save' if @input == 'save'

      handle_input
      if @input.length == 1
        single_letter_guess
      else
        final_guess
      end
=end
  end
end
