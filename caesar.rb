def caesar_cipher (string, number) 
  length = string.length   
  new_string = ""
  string.each_char do |char|
    new_char = ""
    if char == " "
      new_char = " "
    elsif is_upcase?(char) == true 
      new_char = upcase_char_ord(char, number).chr
    else 
      new_char = lowcase_char_ord(char, number)
    end
    new_string << new_char 
  end
  new_string
end

def is_upcase? (character)
  if character.upcase == character
    true
  end
  false
end

def upcase_char_ord (character, number)
  new_character_ordinal = character.ord + number
  if new_character_ordinal > "Z".ord
    return corrected_character_ordinal = "Z".ord - new_character_ordinal + 64
  end
  new_character_ordinal
end

def lowcase_char_ord (character, number)
  new_character_ordinal = character.ord + number
  if new_character_ordinal > "z".ord
    return corrected_character_ordinal = new_character_ordinal - "z".ord + 96
  end
  new_character_ordinal
end

puts caesar_cipher("zy z b", 1)
