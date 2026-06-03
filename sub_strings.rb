dictionary = ["below", "down", "go", "horn", "how", "howdy", "it", "I", "low",
"own", "part", "partner", "sit"]
def substrings (string, dictionary)
  array_of_strings = string.split(' ')
  list = {}
  dictionary.each do |word| 
    array_of_strings.each do |element| 
      if element.include?(word)
        if list.include?(word)
          list[word] = list[word] + 1
        else
          list[word] = 1
        end
      end
    end
  end
  list
end 

puts substrings("below", dictionary)

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
