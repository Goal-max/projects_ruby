def select_words(file, min_length, max_length)
  file.readlines(chomp: true).select do |word|
    word.length.between?(min_length, max_length)
  end
end

f = File.open('/home/rain/Downloads/google-10000-english-no-swears.txt')
min_length = 5
max_length = 12
words = select_words(f, min_length, max_length)

chosen_word = words.sample
puts chosen_word

8.times do

end
