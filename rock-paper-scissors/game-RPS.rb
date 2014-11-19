
class RPSThrow
  def initialize (n)
    throwHash = {
      0 => "rock",
      1 => "paper",
      2 => "scissors",
      "r" => "rock",
      "p" => "paper",
      "s" => "scissors"
    }
    @throw = throwHash[n]
  end

  def throw
    return @throw
  end

  def beats? otherThrow
    winHash = {
      "rock" => "scissors",
      "scissors" => "paper",
      "paper" => "rock"
    }
    return winHash[self.throw] == otherThrow.throw
  end
end

def playRound scores
  while true
    puts "\nPlayer Score: #{scores[0]}, Computer Score: #{scores[1]}"
    print "Choose rock (r), paper (p), or scissors (s):"
    player = RPSThrow.new(gets.chomp)
    computer = RPSThrow.new(rand(3))
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

def playRPS
  scores = [0,0]
  while true
    scores = playRound(scores)
    if scores[0] >= 2
      puts "\nPlayer Wins!"
      break
    elsif scores[1] >= 2
      puts "\nComputer Wins!"
      break
    end
  end
end


playRPS
