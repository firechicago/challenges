class Recipe
  attr_reader :id, :name, :instructions, :description

  def initialize(id, name, instructions, description)
    @id = id
    @name = name
    @instructions = instructions
    @description = description
    @ingredients = []
  end

  def ingredients
    get_all_ingredients.each do |ingredient|
      @ingredients << Ingredient.new(ingredient['name'])
    end
    @ingredients
  end

  def get_all_ingredients
    db_connection do |conn|
      conn.exec_params("
      SELECT *
      FROM ingredients
      WHERE $1 = ingredients.recipe_id
      ", [id])
    end
  end

  def self.all
    recipes = []
    recipe_data = get_all_recipes
    recipe_data.each do |recipe|
      recipes << Recipe.new(
        recipe['id'],
        recipe['name'],
        recipe['instructions'],
        recipe['description'])
    end
    recipes
  end

  def self.get_all_recipes
    recipes = db_connection do |conn|
      conn.exec_params("
      SELECT *
      FROM recipes
      ORDER BY recipes.name
        ")
    end
    recipes
  end

  def self.find(id)
    all.each { |recipe| return recipe if id == recipe.id }
    Recipe.new(
      nil,
      nil,
      "This recipe doesn't have any instructions.",
      "This recipe doesn't have a description.")
  end
end

def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')
    yield(connection)
  ensure
    connection.close
  end
end
