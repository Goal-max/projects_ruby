class GameMenu
  include BasicSerializable

  attr_writer :computer

  def initialize(computer = nil)
    unless computer.nil?
      @computer = computer
      @previous_guesses = []
      @incorrect_guesses = []
      @guesses_remaining = 8
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

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = if instance_variable_get(var).methods.include?(:serialize)
                   # why @computer different to instance_variable_get(var)
                   @computer.serialize
                 else
                   @@serializer.dump(instance_variable_get(var))
                 end
    end
    @@serializer.dump(obj)
  end

  def unserialize(string)
    obj = @@serializer.parse(string)
    obj.each_pair do |key, value|
      if key == '@computer'
        @computer = Computer.new
        @computer.unserialize(value)
      else
        instance_variable_set(key, @@serializer.parse(value))
      end
    end
    binding.b
  end
end
