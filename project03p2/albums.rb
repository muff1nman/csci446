require 'sinatra'
require 'data_mapper'
require_relative 'album'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/albums.sqlite3.db" )

set :port, 8080

get "/form" do
    @rankValues ||= Hash.new
    (1..100).each { |value| @rankValues[value] ||= value }
    erb :form, :locals => { :rank => @rankValues }
end

post "/list" do
    "Sinatra is responding"
end


