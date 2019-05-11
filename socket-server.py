import socket
import os

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind((input("Enter IP address: "), 9909))

while 1 > 0:
    data, addr = server.recvfrom(7)
    print("{}: Data received... ({})".format(addr, data))
    if data == b'turn ++':
        print("\tTurn left!")
        os.system('''sh ./set-car-vector.sh w a''')
    if data == b'turn +-':
        print("\tTurn right!")
        os.system('''sh ./set-car-vector.sh w d''')
    if data == b'turn -+':
        print("\tTurn left!")
        os.system('''sh ./set-car-vector.sh s a''')
    if data == b'turn --':
        print("\tTurn right!")
        os.system('''sh ./set-car-vector.sh s d''')
    if data == b'drive +':
        print("\tGo foward!")
        os.system('''sh ./set-car-vector.sh w _''')
    if data == b'drive -':
        print("\tGo backward!")
        os.system('''sh ./set-car-vector.sh s _''')
    if data == b'brake !':
        print("\tBrake!")
        os.system('''sh ./set-car-vector.sh _ _''')