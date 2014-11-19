# This version implements Rock, Paper, Scissors, Lizard, Spock

class RPSthrow
  def initialize(n)
    throw_hash = {
      0 => "rock",
      1 => "paper",
      2 => "scissors",
      3 => "lizard",
      4 => "Spock",
      "r" => "rock",
      "p" => "paper",
      "s" => "scissors",
      "l" => "lizard",
      "k" => "Spock"
    }
    @throw = throw_hash[n]
  end

  def throw
    @throw
  end

  def beats?(otherThrow)
    win_hash = {
      "rock" => ["scissors", "lizard"],
      "scissors" => ["paper", "lizard"],
      "paper" => ["rock", "Spock"],
      "lizard" => ["paper", "Spock"],
      "Spock" => ["scissors", "rock"]
    }
    win_hash[throw].include?(otherThrow.throw)
  end
end

def play_round(scores)
  loop do
    puts "\nPlayer Score: #{scores[0]}, Computer Score: #{scores[1]}"
    print "Choose rock (r), paper (p), scissors (s), lizard (l), or Spock (k):"
    player = RPSthrow.new(gets.chomp)
    computer = RPSthrow.new(rand(5))
    if player.throw == nil
      puts "Invalid entry, try again."
    else
      puts "Player chose #{player.throw}"
      puts "Computer chose #{computer.throw}"
      if player.beats?(computer)
        puts "#{player.throw.capitalize} beats #{computer.throw}, player wins the round."
        scores[0] += 1
        return scores
      elsif computer.beats?(player)
        puts "#{computer.throw.capitalize} beats #{player.throw}, computer wins the round."
        scores[1] += 1
        return scores
      else
        puts "Tie, choose again."
      end
    end
  end
end

def play_RPS
  scores = [0, 0]
  loop do
    scores = play_round(scores)
    if scores[0] >= 2
      puts "\nPlayer Wins!"
      break
    elsif scores[1] >= 2
      puts "\nComputer Wins!"
      break
    end
  end
end

play_RPS
