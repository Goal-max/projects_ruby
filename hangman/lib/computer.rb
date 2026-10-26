class Computer
  attr_reader :answer

  def initialize(words)
    @secret_word = words.words.sample
    @answer = Array.new(@secret_word.length) { '_' }
  end

  def correct_letter?
    @secret_word.include?(@input)
  end

  def correct_word?(input)
    @secret_word == input
  end

  def update_answer
    @secret_word.each_with_index do |letter, index|
      @answer[index] = input if input == letter
    end
  end

  def already_guessed?
    @answer.include?(input)
  end

  def operate(input)
    @input = input
    update_answer if correct_letter?
  end
end
