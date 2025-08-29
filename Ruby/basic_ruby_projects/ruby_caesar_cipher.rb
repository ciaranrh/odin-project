# frozen_string_literal: true

def caesar_cipher(input, shift)
  shift %= 26 # make sure the shift is in alphabet range
  input.each_char do |char|
    is_upper = (char == char.upcase)
    char.downcase! # much easier handling wrap around logic with a single range of ASCII chars
    if ('a'..'z').include?(char)
      if (char.ord + shift) > 122 # check if outside ASCII range
        # shift will always be in alphabet range now, can just subtract 26 to wrap around
        char = ((char.ord + shift) - 26).chr
        print is_upper ? char.upcase : char
      else
        print is_upper ? (char.ord + shift).chr.upcase : (char.ord + shift).chr
      end
    else
      print char
    end
  end
  puts ''
end

caesar_cipher('What a string!', 5)
# Should get "Bmfy f xywnsl!"
