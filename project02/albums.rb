require 'rack'
require_relative 'form'

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
