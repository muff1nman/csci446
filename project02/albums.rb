require 'rack'
require 'erb'

class Form
    def initialize( formLocation )
        @rank = Hash.new
        @order = Hash.new
        if File.readable?( formLocation) 
            @rawForm = File.open( formLocation, "r" ) { |f| f.read }
        else
            @rawForm = "<html>Form Error!</html>"
        end
        @erb = ERB.new( @rawForm )
    end

    def newOrder( value, display )
        @order[value] = display
    end

    def newRank( value, display )
        @rank[value] = display
    end

    def render()
        @erb.result( get_binding )
    end

    def get_binding()
        binding()
    end

end

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
      ["Rank", "Name", "Year" ].each { |order| form.newOrder( order, order ) }
      (1..100).each { |rank| form.newRank( rank, rank ) }
      response.write ( form.render )
      response.finish
  end

  def do_list( request )
      [ 200, {"Content-Type" => "text/plain" }, ["Do list" ]]
  end

  def do_bad_request( )
      [ 404, {"Content-Type"=> "text/plain" }, ["Are you crazy?!"]]
  end

end

Rack::Handler::WEBrick.run WebApp.new, :Port => 64738
