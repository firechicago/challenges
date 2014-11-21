require "sinatra"
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

def is_complete?(array)
  array.each do |item|
    if item.nil? || item == ""
      return false
    end
  end
  true
end

def is_valid_uri?(uri)
  !! (/^(https?|ftp):\/\/[^\s\/$.?#].[^\s]*$/).match(uri)
end

def post_article(title, url, description)
  new_link = []
  new_link << title
  new_link << url
  new_link << description
  unless is_complete?(new_link)
    return "Submission Failed. Please fill out all fields"
  end
  unless is_valid_uri?(url)
    return "Submission Failed. Invalid URL"
  end
  unless description.length >=20
    return "Submission Failed. Description must contain at least 20 characters."
  end
  current_links = CSV.read("links.csv")
  current_links.each do |link|
    return "Submission Failed. This link has already been submitted." if url == link[1]
  end
  CSV.open("links.csv", "a") do |csv|
    csv << new_link
  end
  "Thanks for submitting \"#{title}\"! <a href=\"../articles\">Click here</a> to go back to the main page"
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
  @message = post_article(@title,@url,@description)
  erb :submit
end
