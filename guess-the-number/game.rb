# YOUR CODE GOES HERE
secret_number = rand(1000) +1
loop do
  print "Guess a number between 1 and 1000: "
  guess = gets.chomp.to_i
  break if guess == secret_number
  puts "Too high, try again." if guess > secret_number
  puts "Too low, try again." if guess < secret_number
end
puts "Congratulations, you guessed the number!"
