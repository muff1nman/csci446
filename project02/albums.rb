require 'rack'

class HelloWorld
  def call(env)
      puts " path: #{env["PATH_INFO"]}"
      puts " script: #{env["SCRIPT_NAME"]}"
      doGet( env ) if env["REQUEST_METHOD"] == "GET"
  end

  def doGet( env )
      [200, {"Content-Type" => "text/plain"}, ["Hi"]]
  end
end

Rack::Handler::WEBrick.run HelloWorld.new, :Port => 64738
