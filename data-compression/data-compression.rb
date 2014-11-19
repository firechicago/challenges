@encoding_mode = "U*"

def lzw_uncompress(compressed_text)
  dictionary = Hash.new
  (0..255).each do |index|
    dictionary[index] = index.chr
  end
  dictionary_index = 256
  compressed_text.reverse!
  plaintext = ""
  current_index = compressed_text.pop
  plaintext += dictionary[current_index]
  until compressed_text.empty?
    prev_index = current_index
    current_index = compressed_text.pop
    string = dictionary[current_index]
    if ! string.nil?
      plaintext << string
      dictionary[dictionary_index] = dictionary[prev_index] + string[0]
      dictionary_index += 1
    else
      string = dictionary[prev_index]
      string += string[0]
      plaintext << string
      dictionary[dictionary_index] = string
      dictionary_index += 1
    end
  end
  plaintext
end


def uncompress_text(filename)
  compressed_text = File.read(filename).unpack(@encoding_mode)
  plaintext = lzw_uncompress(compressed_text)

  File.open(("_" + filename[0..-12]), "w") do |file|
    file.puts plaintext
  end
  puts "file uncompressed \n#{("_" + filename[0..-12])} created"
end

def lzw_compress(plaintext)
  dictionary = Hash.new
  (0..255).each do |index|
    dictionary[index.chr] = index
  end
  dict_index = 256
  compressed_text = []
  plaintext.reverse!
  current_string = plaintext[-1]
  plaintext.chop!
  until plaintext.empty?
    next_char = plaintext[-1]
    plaintext.chop!
    if ! dictionary[current_string + next_char].nil?
      current_string += next_char
    else
      compressed_text << dictionary[current_string]
      dictionary[current_string + next_char] = dict_index
      dict_index += 1
      current_string = next_char
    end
  end
  compressed_text << dictionary[current_string]
  compressed_text = compressed_text[1..-1] if compressed_text[0].nil?
  compressed_text.pack(@encoding_mode)
end

def compress_text(filename)
  cmp_file_name = filename + ".compressed"
  start_time = Time.now
  plaintext = File.read(filename)
  compressed_text = lzw_compress(plaintext)
  File.write(cmp_file_name, compressed_text)
  end_time = Time.now
  file_size = File.new(filename).size
  cmp_file_size = File.new(cmp_file_name).size
  puts "#{cmp_file_name} created\n\n"
  puts "---------------------------------------------------------"
  puts "Original file name: \t#{filename}"
  puts "Compressed file name: \t#{cmp_file_name}"
  puts "Original file size: \t#{file_size/1000}K"
  puts "Compressed file size: \t#{cmp_file_size/1000}K"
  puts "Compression took #{end_time - start_time} seconds"
  puts "Compressed file is #{((1 - (cmp_file_size.to_f/file_size))*100).round(1)}% smaller than the original file"
  puts "Compression Ratio: #{(file_size.to_f/cmp_file_size).round(2)} x"
  puts "---------------------------------------------------------"

end

mode = ARGV[0]
if mode == "-c"
  compress_text(ARGV[1])
elsif mode == "-u"
  uncompress_text(ARGV[1])
end
