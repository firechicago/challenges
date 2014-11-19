def translate(sentence)
  # YOUR CODE GOES HERE
  translation = ""
  sentence_as_array = sentence.split(" ")
  sentence_as_array.each do |word|
    translation += translate_word(word) + " "
  end
  translation[0..-2]
end

def translate_word(word)
  if ["a", "e", "i", "o", "u"].include?(word[0])
    word + "way"
  else
    index = 0
    until ["a", "e", "i", "o", "u", "y"].include?(word[index])
      index += 1
    end
    word[(index)..-1] + word[0..(index-1)] +"ay"
  end
end

input = ARGV.join(" ")
puts translate(input)
# puts translate("these pretzels are making me thirsty")
