#!/usr/bin/env ruby

require 'csv'
require 'pry'

if ARGV.length != 1
  puts "usage: #{__FILE__} \"<actor name>\""
  exit(1)
end

target_actor = ARGV[0]

# YOUR CODE HERE
class Actor
  def initialize(name, id)
    @name = name
    @id = id
    @movies = []
  end

  def movies
    @movies
  end

  def add_movie(movie_id)
    @movies << movie_id
  end
end

class Movie
  def initialize(name, id)
    @name = name
    @id = id
    @cast = []
  end

  def cast
    @cast
  end

  def add_cast_member(actor_id)
    @cast << actor_id
  end
end
