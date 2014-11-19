# require "sinatra"
require "pry"
require "CSV"

links = CSV.read("links.csv")
puts links.to_s
