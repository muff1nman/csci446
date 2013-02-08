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
    sort_by = params[:order].to_sym
    which_rank = params[:rank]
    erb :list, :locals => { :albums => Album.all(:order => [sort_by]), :highlight => which_rank, :sort_by => sort_by }
end

