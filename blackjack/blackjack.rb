#!/usr/bin/env ruby

# YOUR CODE HERE
require 'pry'

class Deck
  def initialize
    @cards = []
    values = [2, 3, 4, 5, 6, 7, 8, 9, 10, :Jack, :Queen, :King, :Ace]
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
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
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
    @cards << deck.draw
    puts "#{@player} was dealt #{@cards.last}"
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

  def to_s
    "#{player} score: #{value}"
  end
end

deck = Deck.new

puts "Welcome to Blackjack\n\n"

player_hand = Hand.new('Player')
dealer_hand = Hand.new('Dealer')

def hit_or_stand(hand, deck)
  loop do
    print 'Hit or stand (H/S):'
    response = gets.chomp.downcase
    if response == 'h'
      hand.hit(deck)
      puts "#{hand}\n\n"
      return :hit
    elsif response == 's'
      return :stand
    else
      puts 'Please type "h" to hit or "s" to stand.'
    end
  end
end

def ai_blackjack(hand, deck)
  2.times { hand.hit(deck) }
  puts "#{hand}\n\n"
  until hand.value > 16
    puts 'Dealer hits.'
    hand.hit(deck)
    puts "#{hand}\n\n"
    if hand.bust?
      puts "\nDealer Busts! You Win!"
      return hand.value
    end
  end
  puts 'Dealer Stands.'
  hand.value
end

def play_blackjack(hand, deck)
  2.times { hand.hit(deck) }
  puts "#{hand}\n\n"
  response = nil
  until response == :stand
    response = hit_or_stand(hand, deck)
    if hand.bust?
      puts "\nBust! You lose..."
      return hand.value
    end
  end
  puts "Player Stands.\n\n"
  hand.value
end

player_score = play_blackjack(player_hand, deck)
unless player_score > 21
  dealer_score = ai_blackjack(dealer_hand, deck)
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
