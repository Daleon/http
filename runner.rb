require './lib/server.rb'

puts "Server's up!!!  Log in at http://127.0.0.1:9292"
instance_of_server = Server.new
instance_of_server.keep_open
