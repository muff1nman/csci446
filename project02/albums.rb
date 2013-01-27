require 'rack'

class HelloWorld
  def call(env)
      request = Rack::Request.new( env )
      case request.path
      when "/form" then do_form( request )
      when "/list" then do_list( request )
      else do_bad_request 
      end

  end

  def do_form( request )
      [ 200, {"Content-Type" => "text/plain" }, ["Do form" ]]
  end

  def do_list( request )
      [ 200, {"Content-Type" => "text/plain" }, ["Do list" ]]
  end

  def do_bad_request( )
      [ 404, {"Content-Type"=> "text/plain" }, ["Are you crazy?!"]]
  end

end

Rack::Handler::WEBrick.run HelloWorld.new, :Port => 64738
