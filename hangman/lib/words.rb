class Words
  attr_reader :words

  def initialize(file_location, min_word_length, max_word_length)
    @words_file = File.open(file_location)
    @min_word_length = min_word_length
    @max_word_length = max_word_length
    @words = select_words
  end

  def select_words
    @words_file.readlines(chomp: true).select do |word|
      word.length.between?(@min_word_length, @max_word_length)
    end
  end
end
