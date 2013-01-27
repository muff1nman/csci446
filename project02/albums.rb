require 'rack'
require_relative 'form'
require_relative 'list'

class WebApp
  def call(env)
      request = Rack::Request.new( env )
      case request.path
      when "/form" then do_form( request )
      when "/list" then do_list( request )
      else do_bad_request 
      end

  end

  def do_form( request )
      response = Rack::Response.new
      form = Form.new( "form.html" )
      form.newOrder( "rank", "Rank (Default)" )
      form.newOrder( "title", "Name" )
      form.newOrder( "year", "Year" )
      (1..100).each { |rank| form.newRank( rank, rank ) }
      response.write ( form.render )
      response.finish
  end

  def do_list( request )
      response = Rack::Response.new
      template = ERB.new( File.open("list.html","r") { |f| f.read } )
      rockAlbums = List.new( "top_100_albums.txt" )
      @albums = rockAlbums.albums.sort { |alb1, alb2| alb1.send(request["order"]) <=> alb2.send( request["order"]) }
      response.write( template.result(binding) )
      response.finish
  end

  def do_bad_request( )
      [ 404, {"Content-Type"=> "text/plain" }, ["Are you crazy?!"]]
  end

end

Rack::Handler::WEBrick.run WebApp.new, :Port => 64738
