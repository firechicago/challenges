#This version uses Rotten Tomatoes API
require "json"
require "net/http"

if !ENV.has_key?("ROTTEN_TOMATOES_API_KEY")
  puts "You need to set the ROTTEN_TOMATOES_API_KEY environment variable."
  exit 1
end

api_key = ENV["ROTTEN_TOMATOES_API_KEY"]
uri = URI("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=#{api_key}")

response = Net::HTTP.get(uri)
movie_data = JSON.parse(response)

puts "In Theaters Now:\n\n"

def title(movie)
  movie["title"]
end

def mpaa_rating(movie)
  movie["mpaa_rating"]
end

def rating(movie)
  (movie["ratings"]["critics_score"] + movie["ratings"]["audience_score"])/2
end

def first_cast_members(movie)
  cast_members = []
  movie["abridged_cast"].each do |cast_member|
    cast_members << cast_member["name"]
  end
  unless cast_members.length == 0
    result = "starring " + cast_members[0..2].join(", ")
  end
end

sorted_movies = movie_data["movies"].sort_by {|movie| rating(movie)}
sorted_movies.reverse!


sorted_movies.each do |movie|
  puts "#{rating(movie)} - #{title(movie)} (#{mpaa_rating(movie)}) #{first_cast_members(movie)}"
end
