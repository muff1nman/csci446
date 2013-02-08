require 'sinatra'
require 'data_mapper'
require_relative 'album'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/albums.sqlite3.db" )

set :port, 8080

before do
    @rankValues = Hash.new
    (1..100).each { |value| @rankValues[value] = value }
end

get "/form" do
    erb :form, :locals => { :rank => @rankValues }
end

post "/list" do
    "Sinatra is responding"
end


