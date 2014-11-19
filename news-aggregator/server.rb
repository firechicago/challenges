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

get "/" do
  @links = read_csv("links.csv")
  erb :index
end
