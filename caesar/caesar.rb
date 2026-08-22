def caesar_cipher(string, number)
  new_string = ''
  string.each_char do |char|
    new_char = shift_character(char, number)
    new_string << new_char
  end
  new_string
end

def shift_character(char, number)
  if !/[A-Za-z]/.match?(char)
    char
  elsif upcase?(char)
    upcase_char_ord(char, number).chr
  else
    lowcase_char_ord(char, number).chr
  end
end

def upcase?(character)
  character.upcase == character
end

def upcase_char_ord(character, number)
  new_character_ordinal = character.ord + number
  if new_character_ordinal > 'Z'.ord
    corrected_character_ordinal = new_character_ordinal - 'Z'.ord + 64
    return corrected_character_ordinal
  end
  new_character_ordinal
end

def lowcase_char_ord(character, number)
  new_character_ordinal = character.ord + number
  if new_character_ordinal > 'z'.ord
    corrected_character_ordinal = new_character_ordinal - 'z'.ord + 96
    return corrected_character_ordinal
  end
  new_character_ordinal
end

string = 'What a string!'
shift_factor = 5
puts "string is: #{string}"
puts "shift factor is: #{shift_factor}"
puts " deciphered string: #{caesar_cipher(string, shift_factor)}"
