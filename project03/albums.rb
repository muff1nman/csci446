require 'rack'
require_relative 'form'
require_relative 'list'

class WebApp

  @@cssFile = 'main.css'

  def call(env)
      request = Rack::Request.new( env )
      generateForm
      case request.path
      when "/form" then do_form( request )
      when "/list" then do_list( request )
      when "/#{@@cssFile}" then do_css( request )
      else do_bad_request 
      end

  end

  # to be removed later
  # maps the html name for the sort option to the display value.
  @@sortOptions = { 
      "rank" => "Rank",
      "name" => "Name",
      "year" => "Year"
  }

  def generateForm () 
      @form = Form.new( "form.html" )
      @rockAlbums = List.new( "albums.sqlite3.db" )
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
      if request["order"].nil?
          @sort_by = @form.defaultOrder
      else
          @sort_by = request["order"]
      end

      # small test to ensure a function doesn't get passed to albums we don't
      # expect
      do_bad_request unless @@sortOptions.has_key? @sort_by

      @albums = @rockAlbums.albums.sort { |alb1, alb2| alb1.send(@sort_by.to_sym) <=> alb2.send(@sort_by.to_sym ) }
      @highlight = request["rank"].to_i
      response.write( template.result(binding) )
      response.finish
  end

  def do_css( request )
      response = Rack::Response.new( [], 200, {"Content-Type" => "text/css" } )
      response.write( File.open(@@cssFile, "r") { |f| f.read } )
      response.finish
  end

  def do_bad_request( )
      [ 404, {"Content-Type"=> "text/plain" }, ["Are you crazy?!"]]
  end

end

Signal.trap('INT') { Rack::Handler::WEBrick.shutdown }
Rack::Handler::WEBrick.run WebApp.new, :Port => 64738
