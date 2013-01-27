require 'rack'

class HelloWorld
  def call(env)
      request = Rack::Request.new( env )
      case request.path
      when "/form" then do_form( request )
      when "/list" then do_form( request )
      else do_bad_request
  end

  def do_form( request )

  end

  def do_list( request )

  end

  def do_bad_request( request )

  end

end

Rack::Handler::WEBrick.run HelloWorld.new, :Port => 64738
