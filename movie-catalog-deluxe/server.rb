require 'sinatra'
require 'pry'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'movies')
    yield(connection)
  ensure
    connection.close
  end
end

def get_credits(actor_id)
  credits = db_connection do |conn|
    # binding.pry
    conn.exec_params("SELECT actors.name, movies.title, movies.id AS movie_id,
    cast_members.character, movies.year FROM actors LEFT JOIN cast_members
    ON actors.id = cast_members.actor_id JOIN movies ON cast_members.movie_id =
    movies.id WHERE actors.id = $1 ORDER BY movies.year ", [actor_id])
  end
  credits
end

def actors_list(page)
  actors = db_connection do |conn|
    offset = (page - 1) * 20
    # binding.pry
    conn.exec_params("SELECT actors.id, actors.name FROM actors ORDER BY
    actors.name LIMIT 20 OFFSET $1", [offset])
  end
  actors
end

def get_movies(page, order)
  movies = db_connection do |conn|
    offset = (page - 1) * 20
    # binding.pry
    conn.exec_params("SELECT movies.id, movies.title, movies.year, movies.rating,
    genres.name AS genre, studios.name AS studio FROM movies LEFT JOIN genres
    ON movies.genre_id = genres.id LEFT JOIN studios ON movies.studio_id =
    studios.id  ORDER BY movies.#{order} LIMIT 20 OFFSET $1", [offset])
  end
  movies
end

def get_cast(movie_id)
  cast_data = db_connection do |conn|
    conn.exec_params("SELECT actors.id, cast_members.character, actors.name
    FROM cast_members JOIN actors ON cast_members.actor_id = actors.id
    WHERE cast_members.movie_id = $1", [movie_id])
  end
  cast_data
end

def get_movie_data(movie_id)
  movie_data = db_connection do |conn|
    conn.exec_params("SELECT movies.id, movies.title, movies.year,
    movies.synopsis, movies.rating, genres.name AS genre, studios.name AS studio
    FROM movies LEFT JOIN genres ON movies.genre_id = genres.id LEFT JOIN
    studios ON movies.studio_id = studios.id  WHERE movies.id = $1", [movie_id])
  end
  movie_data
end

get '/movies' do
  page = params[:page].to_i
  if params[:order] == 'year' || params[:order] == 'rating'
    @order = params[:order]
  else
    @order = 'title'
  end
  page = 1 unless page >= 1
  @page = page
  @movies = get_movies(@page, @order)
  # binding.pry
  erb :'movies/index'
end

get '/movies/:id' do
  @movie = get_movie_data(params[:id])[0]
  @cast = get_cast(params[:id])
  @size_of_cast = @cast.ntuples
  # binding.pry
  erb :'movies/show'
end

get '/actors' do
  @page = params[:page].to_i
  @page = 1 unless @page >= 1
  @actors_list = actors_list(@page)
  erb :'actors/index'
end

get '/actors/:id' do
  @actor_id = params[:id]
  @credits = get_credits(@actor_id)
  # binding.pry
  erb :'actors/show'
end
