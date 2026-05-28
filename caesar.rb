def caesar_cipher (string, number) do
  length = string.length   
  new_string = ""
  string.each_char do |char|
    new_char = ""
    if is_upcase?(char)  
      new_char = upcase_char_ord(char).chr
    else 
      new_char = lowcase_char_ord(char).chr
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

def upcase_char_ord (character)
  new_character_ordinal = character.ord + 5
  if new_character_ordinal > "Z".ord
    return corrected_character_ordinal = "Z".ord - new_character_ordinal + 64
  end
  new_character_ordinal
end

def lowcase_char_ord (char)
  new_character_ordinal = char.ord + 5
  if new_character_ordinal > "z".ord
    return corrected_character_ordinal = "z".ord - new_character_ordinal + 96
  end
  new_character_ordinal
end
