require 'csv'
require 'pry'

if ARGV.length < 1
  puts "usage: #{__FILE__} \"<actor name>\""
  exit(1)
end

target_actor = ARGV[0]
marky_mark_id = ARGV[1] || '1841'

# YOUR CODE HERE
class Actor
  def initialize(name, id)
    @name = name
    @id = id
    @movies = []
  end

  attr_reader :name, :id, :movies

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

  attr_reader :name, :id, :cast

  def add_cast_member(actor_id)
    @cast << actor_id
  end
end

def connections(node)
  result = []
  if node.class == Movie
    node.cast.each { |cast_id| result << @actors[cast_id] }
  elsif node.class == Actor
    node.movies.each { |movie_id| result << @movies[movie_id] }
  end
  result
end

start_time = Time.now

actors_data = CSV.read('actors.csv')
@actors = {}
actors_data.each do |row|
  @actors[row[0]] = Actor.new(row[1], row[0])
  @actors[row[1]] = @actors[row[0]]
end

movies_data = CSV.read('movies.csv')
@movies = {}
movies_data.each do |row|
  @movies[row[0]] = Movie.new(row[1], row[0])
  @movies[row[1]] = @movies[row[0]]
end

cast_data = CSV.read('cast_members.csv')
cast_data.each do |row|
  @actors[row[0]].add_movie(row[1])
  @movies[row[1]].add_cast_member(row[0])
end

end_time = Time.now

puts "Database built in #{end_time - start_time} seconds."

def pathfind(start_actor, end_actor)
  previous = {}
  queue = []
  current_node = @actors[start_actor]
  goal = @actors[end_actor]
  until current_node == goal
    check_connections(current_node, previous, queue, goal)
    return nil if queue.empty?
    current_node = queue.shift
  end
  recover_path(current_node, @actors[start_actor], previous)
end

def check_connections(current_node, previous_hash, queue, goal)
  connections(current_node).each do |connection|
    next if previous_hash[connection]
    queue << connection
    previous_hash[connection] = current_node
    if connection == goal
      current_node = connection
      break
    end
  end
end

def recover_path(end_node, start_node, previous_hash)
  path = [end_node.name]
  current_node = end_node
  until current_node == start_node
    # binding.pry
    current_node = previous_hash[current_node]
    path << current_node.name
  end
  path
end

path = pathfind(target_actor, marky_mark_id)
if @actors[target_actor].nil?
  puts "#{target_actor} is not in the database"
elsif path
  type = 'Actor:'
  path.each do |node|
    puts "#{type} #{node}"
    if type == 'Actor:'
      type = 'Movie:'
    else
      type = 'Actor:'
    end
  end
else
  puts "There is no connection between #{target_actor} and Marky Mark."
end
