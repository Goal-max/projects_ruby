class Words
  include BasicSerializable

  attr_reader :words

  def initialize
    @words_file = File.open('/home/rain/Downloads/google-10000-english-no-swears.txt')
    @min_word_length = 5
    @max_word_length = 12
    @words = select_words
  end

  def select_words
    @words_file.readlines(chomp: true).select do |word|
      word.length.between?(@min_word_length, @max_word_length)
    end
  end
end
