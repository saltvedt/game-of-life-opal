require 'opal'
require 'opal-jquery'

server = Opal::Server.new do |server|
  server.append_path 'app'
  server.main = 'game-of-life'
  server.index_path = 'index.erb'
  server.debug = true
end
run server
