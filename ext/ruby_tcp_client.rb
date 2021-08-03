require 'socket'

server = TCPSocket.open('yacrud-server', 4000)

server.puts 'Hey Server!'

response = server.gets
puts "Response: #{response}"

server.close
