import socket
import os

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server.bind("0.0.0.0", 4404)

while 1 > 0:
    data, addr = server.recvfrom(7)
    if data == 'turn ++':
        os.system('''sh ./set-car-vector.sh w a''')
        print(f"{addr}: Turn left!")
    if data == 'turn +-':
        os.system('''sh ./set-car-vector.sh w d''')
        print(f"{addr}: Turn right!")
    if data == 'turn -+':
        os.system('''sh ./set-car-vector.sh s a''')
        print(f"{addr}: Turn left!")
    if data == 'turn --':
        os.system('''sh ./set-car-vector.sh s d''')
        print(f"{addr}: Turn right!")
    if data == 'drive +':
        os.system('''sh ./set-car-vector.sh w _''')
        print(f"{addr}: Go forwards!")
    if data == 'drive -':
        os.system('''sh ./set-car-vector.sh s _''')
        print(f"{addr}: Go backwards!")
    if data == 'brake !':
        os.system('''sh ./set-car-vector.sh _ _''')
        print(f"{addr}: Brake!")