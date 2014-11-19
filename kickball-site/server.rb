require "sinatra"
require "JSON"
require "pry"
file = JSON.parse(File.read("roster.json"))
# puts file

@positions = []
file.each do |teamname, roster|
  roster.each do |position, player|
    @positions << position
  end
end
@positions.uniq!

get '/' do
  @team_names = []
  # binding.pry
  file.each do |team_name, roster|
    @team_names << team_name
  end
  @positions = []
  file.each do |teamname, roster|
    roster.each do |position, player|
      @positions << position
    end
  end
  @positions.uniq!
  erb :index
end

file.each do |teamname, roster|
  get "/#{teamname}" do
    text = ""
    text << "<h1>#{teamname}</h1>"
    roster.each do |position, player|
      text << "<p>#{player}, #{position}</p>"
    end
    text
  end
end

@positions.each do |position|
  get "/#{position.delete(" ")}" do
    text = ""
    text << "<h1>#{position}</h1>"
    file.each do |teamname, roster|
      roster.each do |position_current, player|
        if position_current == position
          text << "<p>#{player}, #{teamname}</p>"
        end
      end
    end
    text
  end
end
