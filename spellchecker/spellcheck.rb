#!/usr/bin/env ruby
def word_frequencies(filename)
  corpus_as_string = File.read(filename)
  corpus_as_array = corpus_as_string.downcase.split(/[^abcdefghijklmnopqrstuvwxyz']/)
  result = Hash.new(0)
  corpus_as_array.each do |word|
    result[word] += 1
  end
  result
end

@frequency_hash = word_frequencies("lotsowords.txt")
puts "All trained up!"


def generate_possibilities(word)
  possibilities = [word]
  #check transpositions
  (0..(word.length - 2)).each do |index|
    possibilities << word[0...index] + word[index+1] + word[index] + word[(index+2)..-1]
  end
  #check substitutions
  (0..(word.length - 1)).each do |index|
    "abcdefghijklmnopqrstuvwxyz".each_char do |char|
      possibilities << word[0...index] + char + word[(index+1)..-1]
    end
  end
  #check insertions
  (0..(word.length - 1)).each do |index|
    possibilities << word[0...index] + word[(index+1)..-1]
  end
  #check deletions
  (0..(word.length - 1)).each do |index|
    "abcdefghijklmnopqrstuvwxyz".each_char do |char|
      possibilities << word[0...index] + char + word[(index)..-1]
    end
  end
  possibilities
end

def generate_double_possibilities(word)
  possibilities = []
  one_step_possibilities = generate_possibilities(word)
  one_step_possibilities.each do |possible_word_1|
    two_step_possibilities = generate_possibilities(possible_word_1)
    two_step_possibilities.each do |possible_word_2|
      possibilities << possible_word_2
    end
  end
  possibilities
end


def spellcheck(word)
  #check if the word is valid
  return word if @frequency_hash[word] > 0
  #check if there is a valid word within one step
  possibilities = generate_possibilities(word)
  correct_word = possibilities.max_by {|word| @frequency_hash[word]}
  #check if there is a valid word within two steps
  unless @frequency_hash[correct_word] > 0
    possibilities = generate_double_possibilities(word)
    correct_word = possibilities.max_by {|word| @frequency_hash[word]}
  end
  #if still no valid word, give up and flag the word with "(sp?)"
  return word + "(sp?)" if @frequency_hash[correct_word] == 0
  #if there is a valid word, return it
  correct_word
end

def correct(sentence)
  corrected_words = []
  sentence.each do |word|
    corrected_words << spellcheck(word.downcase)
  end
  corrected_words
end

input = ARGV
puts correct(input).join(" ")
