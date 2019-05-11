import socket
import os

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server.bind((input("Enter IP address: "), 4404))

while 1 > 0:
    data, addr = server.recvfrom(7)
    if data == 'turn ++':
        os.system('''sh ./set-car-vector.sh w a''')
        print("{}: Turn left!".format(addr))
    if data == 'turn +-':
        os.system('''sh ./set-car-vector.sh w d''')
        print("{}: Turn right!".format(addr))
    if data == 'turn -+':
        os.system('''sh ./set-car-vector.sh s a''')
        print("{}: Turn left!".format(addr))
    if data == 'turn --':
        os.system('''sh ./set-car-vector.sh s d''')
        print("{}: Turn right!".format(addr))
    if data == 'drive +':
        os.system('''sh ./set-car-vector.sh w _''')
        print("{}: Go forwards!".format(addr))
    if data == 'drive -':
        os.system('''sh ./set-car-vector.sh s _''')
        print("{}: Go backwards!".format(addr))
    if data == 'brake !':
        os.system('''sh ./set-car-vector.sh _ _''')
        print("{}: Brake!".format(addr))