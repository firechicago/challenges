require "sinatra"
require "pry"
require "csv"

movies = CSV.read("movies.csv")

titles = []
movies_hash = Hash.new

movies[1..-1].each do |movie|
  titles << movie[0..1]
  this_movie_hash = {
    title:movie[1],
    year:movie[2],
    synopsis:movie[3],
    rating:movie[4],
    genre:movie[5],
    studio:movie[6],
  }
  movies_hash[movie[0]] = this_movie_hash
end

titles.sort_by!{|movie| movie[1]}

get "/movies" do
  @titles = titles
  # binding.pry
  erb :index
end

get "/movies/:movie_id" do
  @movie_info = movies_hash[params[:movie_id]]
  # binding.pry
  erb :movie
end
