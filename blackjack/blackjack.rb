#!/usr/bin/env ruby

# YOUR CODE HERE
require 'pry'

class Deck
  def initialize
    @cards = []
    values = [2,3,4,5,6,7,8,9,10,:Jack, :Queen, :King, :Ace]
    suits = ['♣', '♥', '♦', '♠']
    values.each do |value|
      suits.each do |suit|
        @cards << Card.new(value, suit)
      end
    end
    @cards.shuffle!
  end

  def draw
    @cards.pop
  end
end

class Card
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  attr_reader :value, :suit

  def name
    "#{value} of #{suit}"
  end

  def face?
    [:Jack, :Queen, :King].include?(value)
  end

  def ace?
    value == :Ace
  end
end

class Hand
  def initialize(player)
    @cards = []
    @player = player
  end

  attr_reader :player

  def hit(deck)
    new_card = deck.draw
    @cards << new_card
    puts "#{@player} was dealt #{new_card.name}"
  end

  def value
    result = 0
    num_aces = 0
    @cards.each do |card|
      if card.face?
        result += 10
      elsif card.ace?
        num_aces += 1
        result += 11
      else
        result += card.value
      end
    end
    num_aces.times { result -= 10 if result > 21 }
    result
  end

  def bust?
    value > 21
  end
end

deck = Deck.new

puts "Welcome to Blackjack\n\n"

player_hand = Hand.new('Player')
dealer_hand = Hand.new('Dealer')

def play_blackjack(hand, ai, deck)
  2.times {hand.hit(deck)}
  puts "#{hand.player} score: #{hand.value}"
  if ai
    until hand.value > 16
      hand.hit(deck)
      puts "#{hand.player} score: #{hand.value}"
      if hand.bust?
        puts "Bust! You Win!"
        return hand.value
      end
    end
    puts "Dealer Stands."
    return hand.value
  else
    response = ''
    until response == 's'
      print 'Hit or stand (H/S):'
      response = gets.chomp.downcase
      if response == 'h'
        hand.hit(deck)
        puts "#{hand.player} score: #{hand.value}"
      elsif response != 's'
        puts 'Please type "h" to hit or "s" to stand.'
      end
      if hand.bust?
        puts "\nBust! You lose..."
        return hand.value
      end
    end
    return hand.value
  end
end

player_score = play_blackjack(player_hand, false, deck)
unless player_score > 21
  dealer_score = play_blackjack(dealer_hand, true, deck)
  if dealer_score > 21
    puts ''
  elsif player_score > dealer_score
    puts 'You Win!'
  elsif player_score < dealer_score
    puts 'You lose...'
  else
    puts 'Push'
  end
end
