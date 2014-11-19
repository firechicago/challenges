require "sinatra"
require "pry"
require "CSV"



def read_csv(filename)
  raw_data = CSV.read(filename)
  links = []
  raw_data.each do |link|
    new_link = {
      title:link[0],
      url:link[1],
      description:link[2]
    }
    links << new_link
  end
  links.reverse
end

def post_article(title, url, description)
  new_link = []
  new_link << title
  new_link << url
  new_link << description
  current_links = CSV.read("links.csv")
  CSV.open("links.csv", "w") do |csv|
    current_links.each {|link| csv << link}
    csv << new_link
  end
end


get "/articles" do
  @links = read_csv("links.csv")
  erb :index
end

get "/articles/new" do
  erb :submit
end

post "/submission" do
  @title = params[:title]
  @url = params[:url]
  @description = params[:description]
  post_article(@title,@url,@description)
  @message = "Thanks for submitting \"#{@title}\"!"
  erb :submit
end
