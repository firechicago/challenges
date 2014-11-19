n = ARGV[0].to_i
def monty_hall n
  doors = ["goat", "goat", "car"]

  stay_wins = 0
  n.times do
    mix_doors = doors.shuffle
    choice = rand(3)
    stay_wins += 1 if mix_doors[choice] == "car"
  end

  switch_wins = 0
  n.times do
    mix_doors = doors.shuffle
    choice = rand(3)
    switch_wins += 1 if mix_doors[choice] == "goat"
  end

  puts "Percentage games guessed correctly:"
  puts "With switching: #{(switch_wins.to_f/n)*100}%"
  puts "Without switching: #{(stay_wins.to_f/n)*100}%"
end
monty_hall n
