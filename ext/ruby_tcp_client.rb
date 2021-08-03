require 'socket'

server = TCPSocket.open('yacrud-server', 4000)

server.puts 'Hey Server!'

response = ''

while line = server.gets
  response += line
end

puts "Response: #{response}"

server.close
