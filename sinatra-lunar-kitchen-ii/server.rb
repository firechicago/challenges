require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/activerecord'

require_relative 'models/recipe'
require_relative 'models/ingredient'

configure :development, :test do
  require 'pry'
end

get '/' do
  erb :'index'
end

get '/recipes' do
  @recipes = Recipe.all
  erb :'recipes/index'
end

get '/recipes/:id' do
  begin
    @recipe = Recipe.find(params[:id])
    erb :'recipes/show'
  rescue
    "This recipe doesn't have a description.
    This recipe doesn't have any instructions."
  end
end
