import socket
import os

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server.bind((input("Enter IP address: "), 9909))

while 1 > 0:
    data, addr = server.recvfrom(7)
    if data == 'turn ++':
        print("{}: Turn left!".format(addr))
        os.system('''sh ./set-car-vector.sh w a''')
    if data == 'turn +-':
        print("{}: Turn right!".format(addr))
        os.system('''sh ./set-car-vector.sh w d''')
    if data == 'turn -+':
        print("{}: Turn left!".format(addr))
        os.system('''sh ./set-car-vector.sh s a''')
    if data == 'turn --':
        print("{}: Turn right!".format(addr))
        os.system('''sh ./set-car-vector.sh s d''')
    if data == 'drive +':
        print("{}: Go forwards!".format(addr))
        os.system('''sh ./set-car-vector.sh w _''')
    if data == 'drive -':
        print("{}: Go backwards!".format(addr))
        os.system('''sh ./set-car-vector.sh s _''')
    if data == 'brake !':
        print("{}: Brake!".format(addr))
        os.system('''sh ./set-car-vector.sh _ _''')