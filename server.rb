require 'socket'      # Sockets are in standard library
require 'json'
require 'time'

host = 'localhost'
port = 4567

s = TCPServer.open(host, port)

loop {                         # Servers run forever
  client = s.accept       # Wait for a client to connect
  request = client.gets
  puts request
  
  out = []
  out << "HTTP/1.1 200 OK"
  out << "Content-Type: application/json; charset=UTF-8"
  out << "Date: #{Time.now}"
  out << "Transfer-Encoding: chunked"
  client.print out.join("\r\n") + "\r\n\r\n"
  
  chunks = 0
  while true do
    sleep rand(5)
    puts "Send data"
    data = {:hello => "This is chunk #{chunks}", :time => Time.now.iso8601}.to_json
    client.print "#{data.bytesize.to_s(16)};extension"
    client.print "\r\n"
    client.print data
    client.print "\r\n"
    
    chunks=chunks+1
    
    break if rand(20)>19
  end
  client.print "\0\r\n\r\n"
  client.close                 # Disconnect from the client
}
s.close               # Close the socket when done