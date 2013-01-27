require 'rack'
require_relative 'form'
require_relative 'list'

class WebApp
  def call(env)
      request = Rack::Request.new( env )
      generateForm
      case request.path
      when "/form" then do_form( request )
      when "/list" then do_list( request )
      else do_bad_request 
      end

  end

  @@sortOptions = { 
      "rank" => "Rank",
      "name" => "Name",
      "year" => "Year"
  }

  def generateForm () 
      @form = Form.new( "form.html" )
      @@sortOptions.each { |key, value| @form.newOrder( key, value ) } 
      @form.defaultOrder = "rank"
      (1..100).each { |rank| @form.newRank( rank, rank ) }
  end

  def do_form( request )
      response = Rack::Response.new
      response.write ( @form.render )
      response.finish
  end

  def do_list( request )
      response = Rack::Response.new
      template = ERB.new( File.open("list.html","r") { |f| f.read } )
      rockAlbums = List.new( "top_100_albums.txt" )
      if request["order"].nil?
          @sort_by = @form.defaultOrder
      else
          @sort_by = request["order"]
      end
      @albums = rockAlbums.albums.sort { |alb1, alb2| alb1.send(@sort_by.to_sym) <=> alb2.send(@sort_by.to_sym ) }
      @highlight = request["rank"].to_i
      response.write( template.result(binding) )
      response.finish
  end

  def do_bad_request( )
      [ 404, {"Content-Type"=> "text/plain" }, ["Are you crazy?!"]]
  end

end

Rack::Handler::WEBrick.run WebApp.new, :Port => 64738
