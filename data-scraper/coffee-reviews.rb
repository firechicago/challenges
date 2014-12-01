require 'open-uri'
require 'nokogiri'

uri = open('http://www.amazon.com/s/?ie=UTF8&keywords=amazon+coffee+makers&tag=googhydr-20&index=garden&hvadid=34481538587&hvpos=1t1&hvexid=&hvnetw=g&hvrand=839640366302276393&hvpone=&hvptwo=&hvqmt=e&hvdev=c&ref=pd_sl_6snr5ult3g_e', {"User-Agent" => "Chrome"}).read

doc = Nokogiri::HTML(uri)
result = doc.css(".s-access-detail-page")
links = []
result.each do |link|
  links << link[:href]
end

coffee_makers = []
links.each do |link|
  machine = open(link, {"User-Agent" => "Chrome"}).read
  machine_object = Nokogiri::HTML(machine)
  coffee_makers << machine_object
end

review_objects = []
coffee_makers.each do |page|
  review_objects << page.css("div#revMHRL div.a-section div.a-row div.a-section")
end

coffee_string = ''

review_objects.each do |coffee_maker|
  coffee_maker.each do |review|
    coffee_string += review.text
  end
end

File.write('coffee_reviews.txt', coffee_string)

word_hash = Hash.new(0)
stop_words = File.read('stop_words.txt')

coffee_string = File.read("coffee_reviews.txt")

coffee_string.scan(/\w+/).each do |word|
  unless stop_words.include?(word.downcase)
    word.downcase!
    word_hash[word.to_sym] += 1
  end
end

sentences = coffee_string.split(/[.?!\n*]/)

sentence_points_hash = Hash.new(0)
sentences.each do |sentence|
  sentence.downcase.split(/\W+/).each do |word|
    sentence_points_hash[sentence] += word_hash[word.to_sym]
  end
end

number = 10

sentence_points_hash = sentence_points_hash.sort_by { |_word, count| count }.reverse
sentence_points_hash.first(number).each do |sentence, count|
  puts "#{sentence}"
end
