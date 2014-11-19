require "json"
file = File.read("students.json")
grade_book = JSON.parse(file)

# puts grade_book

puts "Student\tAverage\tHighest\tLowest"

grade_book["students"].each do |student|
  name = student["name"]
  average = (student["grades"].inject { |sum, n| sum + n }).to_f / student["grades"].length
  highest = student["grades"].max
  lowest = student["grades"].min
  puts "#{name}\t#{average}\t#{highest}\t#{lowest}"
end
