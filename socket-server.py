import socket
import os

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server.bind(("0.0.0.0", 4404))

while 1 > 0:
    data, addr = server.recvfrom(7)
    print("{}: data".format(addr))
    if data == 'turn ++':
        print("{}: Turn left!".format(addr))
    if data == 'turn +-':
        print("{}: Turn right!".format(addr))
    if data == 'turn -+':
        print("{}: Turn left!".format(addr))
    if data == 'turn --':
        print("{}: Turn right!".format(addr))
    if data == 'drive +':
        print("{}: Go forwards!".format(addr))
    if data == 'drive -':
        print("{}: Go backwards!".format(addr))
    if data == 'brake !':
        print("{}: Brake!".format(addr))