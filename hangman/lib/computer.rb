class Computer
  attr_reader :answer

  def initialize(words)
    @secret_word = words.words.sample.split('')
    @answer = Array.new(@secret_word.length) { '_' }
  end

  def correct_letter?(input)
    @secret_word.include?(input)
  end

  def correct_word?(input)
    @secret_word == input
  end

  def update_answer(input)
    @secret_word.each_with_index do |letter, index|
      @answer[index] = input if input == letter
    end
  end

  def already_guessed?
    @answer.include?(input)
  end

  def reveal_word
    puts "Answer is: #{@secret_word.join}"
  end
end
