require "pry"

@encoding_mode = "U*"

class Leaf
  attr_accessor(:value,:character,:one_branch,:zero_branch)
end

def build_huffman_dict(top_node)
  @dictionary = Hash.new
  prefix = ""
  def traverse(node, prefix)
    unless node.zero_branch.nil?
      traverse(node.zero_branch,prefix + "0")
      traverse(node.one_branch,prefix + "1")
    else
      @dictionary[node.character] = prefix
    end
  end
  traverse(top_node, prefix)
  @dictionary
end


def huffman_uncompress(compressed_text)

end

def uncompress_text(filename)
  compressed_text = File.read(filename).unpack(@encoding_mode)
  plaintext = huffman_uncompress(compressed_text)

  File.open(("_" + filename[0..-12]), "w") do |file|
    file.puts plaintext
  end
  puts "file uncompressed \n#{("_" + filename[0..-12])} created"
end

def new_parent(zero_leaf,one_leaf)
  parent = Leaf.new
  parent.character = nil
  parent.value = zero_leaf.value + one_leaf.value
  parent.zero_branch = zero_leaf
  parent.one_branch = one_leaf
  parent
end

def huffman_compress(plaintext)
  frequency = Hash.new(0)
  plaintext.each_char do |char|
    frequency[char] += 1
  end
  first_queue = []
  second_queue = []
  frequency.each do |char, value|
    leaf = Leaf.new
    leaf.character = char
    leaf.value = value
    leaf.one_branch = nil
    leaf.zero_branch = nil
    first_queue << leaf
  end
  first_queue.sort_by! {|leaf| leaf.value}
  first_queue.reverse!
  until first_queue.empty?
    if second_queue.empty? || first_queue.last.value < second_queue.last.value
      left = first_queue.pop
    else
      left = second_queue.pop
    end
    if second_queue.empty? || first_queue.last.value < second_queue.last.value
      right = first_queue.pop
    else
      right = second_queue.pop
    end
    new_leaf = new_parent(left,right)
    second_queue.unshift(new_leaf)
  end
  new_leaf = new_parent(second_queue[0],second_queue[1])
  # binding.pry
  dictionary = build_huffman_dict(new_leaf)
  puts dictionary
  compressed_text = []
  plaintext.each_char do |char|
    compressed_text << dictionary[char]
  end
  compressed_text
end
puts huffman_compress(ARGV[0])
# def compress_text(filename)
#   cmp_file_name = filename + ".compressed"
#   start_time = Time.now
#   plaintext = File.read(filename)
#   compressed_text = huffman_compress(plaintext)
#   File.write(cmp_file_name, compressed_text)
#   end_time = Time.now
#   file_size = File.new(filename).size
#   cmp_file_size = File.new(cmp_file_name).size
#   puts "#{cmp_file_name} created\n\n"
#   puts "---------------------------------------------------------"
#   puts "Original file name: \t#{filename}"
#   puts "Compressed file name: \t#{cmp_file_name}"
#   puts "Original file size: \t#{file_size/1000}K"
#   puts "Compressed file size: \t#{cmp_file_size/1000}K"
#   puts "Compression took #{end_time - start_time} seconds"
#   puts "Compressed file is #{((1 - (cmp_file_size.to_f/file_size))*100).round(1)}% smaller than the original file"
#   puts "Compression Ratio: #{(file_size.to_f/cmp_file_size).round(2)} x"
#   puts "---------------------------------------------------------"
#
# end
#
# mode = ARGV[0]
# if mode == "-c"
#   compress_text(ARGV[1])
# elsif mode == "-u"
#   uncompress_text(ARGV[1])
# end
