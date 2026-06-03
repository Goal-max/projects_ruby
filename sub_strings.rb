dictionary = ["below", "down", "go", "horn", "how", "howdy", "it", "I", "low",
"own", "part", "partner", "sit"]
def substrings (string, dictionary)
  list = {}
  dictionary.each do |word| 
    if string.include?(word)
      if list.include?(word)
        list[word] = list[word] + 1
      else
        list[word] = 1
      end
    end
  end
  list
end 

puts substrings("below", dictionary)
