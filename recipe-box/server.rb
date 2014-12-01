require 'pry'
require 'sinatra'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')
    yield(connection)
  ensure
    connection.close
  end
end

def recipes_list(page)
  recipes = db_connection do |conn|
    offset = (page - 1) * 20
    conn.exec_params("
      SELECT recipes.id, recipes.name, recipes.description
      FROM recipes
      ORDER BY recipes.name
      LIMIT 20 OFFSET $1", [offset])
  end
  recipes
end

def get_recipe(id)
  recipe_info = db_connection do |conn|
    conn.exec_params("
    SELECT recipes.name, recipes.description, recipes.instructions,
      ingredients.name AS ingredient
    FROM recipes LEFT JOIN ingredients ON ingredients.recipe_id = recipes.id
    WHERE recipes.id = $1", [id])
  end
  recipe_info
end

get '/recipes' do
  page = params[:page].to_i
  page = 1 unless page >= 1
  @page = page
  @page_title = "Christopher's Recipe Box"
  @recipes = recipes_list(@page)
  erb :'recipes/index'
end

get '/recipes/:id' do
  @recipe_info = get_recipe(params[:id])
  @page_title = @recipe_info[0]['name']
  description = @recipe_info[0]['description'].delete("\t").split("\n")
  @description = ''
  description.each { |para| @description += '<p>' + para + '</p>' }
  instructions = @recipe_info[0]['instructions'].delete("\t").split("\n")
  @instructions = ''
  instructions[2..-1].each { |para| @instructions += '<p>' + para + '</p>' }
  erb :'recipes/show'
end
