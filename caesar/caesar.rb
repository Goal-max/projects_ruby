def caesar_cipher(string, number)
  new_string = ''
  string.each_char do |char|
    new_char = shift_character(char, number)
    new_string << new_char
  end
  new_string
end

def shift_character(char, number)
  if /[A-Z]/.match?(char)
    char = char.downcase
    new_letter(char, number).upcase
  elsif /[a-z]/.match?(char)
    new_letter(char, number)
  else
    char
  end
end

def new_letter(character, number)
  new_letter_ordinal = character.ord + number
  z_ordinal = 'z'.ord
  if new_letter_ordinal > z_ordinal
    corrected_character_ordinal = new_letter_ordinal - z_ordinal + 96
    return corrected_character_ordinal.chr
  end
  new_letter_ordinal.chr
end

# input
string = 'What a string!'
shift_factor = 5

# output
puts "string is: #{string}"
puts "shift factor is: #{shift_factor}"
puts "deciphered string: #{caesar_cipher(string, shift_factor)}"
