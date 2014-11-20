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
  @page_number = [Integer(params[:page] || 1),1].max
  @titles = titles[((@page_number-1)*20)..(@page_number*20)]
  erb :index
end

get "/movies/:movie_id" do
  @movie_info = movies_hash[params[:movie_id]]
  erb :movie
end

get "/search" do
  @search_string = params[:search_string]
  @found_movies = []
  movies_hash.each do |index, movie|
    # binding.pry
    if (movie[:title].to_s + movie[:synopsis].to_s).downcase.include?(@search_string.downcase)
      @found_movies << [index, movie[:title]]
    end
  end
  @page_number = [Integer(params[:page] || 1),1].max
  @titles = @found_movies[((@page_number-1)*20)..(@page_number*20)]
  erb :search
end
