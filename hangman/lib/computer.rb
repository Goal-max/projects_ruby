class Computer
  def initialize(words)
    @secret_word = words.words.sample
  end

  def correct_letter?(input)
    @secret_word.include?(input)
  end

  def correct_word?(input)
    @secret_word == input
  end
end
