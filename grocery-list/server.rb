require "sinatra"

get "/groceries" do
  @grocery_list = File.readlines("grocery_list.txt")
  erb :index
end

post "/groceries" do
  File.open("grocery_list.txt", "a") do |f|
    f.write(params[:item] + "\n")
  end
  @grocery_list = File.readlines("grocery_list.txt")
  erb :index
end
