require 'socket'

socket = TCPServer.new(444)
loop do
    client = server.accept
end