require "sinatra"
require "JSON"
file = JSON.parse(File.read("roster.json"))
# puts file

positions = []
file.each do |teamname, roster|
  roster.each do |position, player|
    positions << position
  end
end
positions.uniq!

get '/' do
  text = "<h1>League of Cool Kickball Professionals</h1>"
  text << "<h3>Team Rosters</h3>"
  file.each do |teamname, roster|
    text << "<a href=\"#{teamname.delete(" ")}\"><p>#{teamname}</p></a>"
  end
  text << "<h3>Players by Position</h3>"
  positions.each do |position|
    text << "<a href=\"#{position.delete(" ")}\"><p>#{position}</p></a>"
  end
  text
end

file.each do |teamname, roster|
  get "/#{teamname.delete(" ")}" do
    text = ""
    text << "<h1>#{teamname}</h1>"
    roster.each do |position, player|
      text << "<p>#{player}, #{position}</p>"
    end
    text
  end
end

positions.each do |position|
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
