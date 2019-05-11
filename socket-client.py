import keyboard
import socket
import time

ipaddr = input("Enter IP address: ")
client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

while 1 > 0:
    if keyboard.is_pressed('w'):
        if keyboard.is_pressed('a'):
            client.sendto("turn ++".encode('utf-8'), (ipaddr, 9909))
            time.sleep(0.1)
        elif keyboard.is_pressed('d'):
            client.sendto("turn +-".encode('utf-8'), (ipaddr, 9909))
            time.sleep(0.1)
        else:
            client.sendto("drive +".encode('utf-8'), (ipaddr, 9909))
            time.sleep(0.1)
    elif keyboard.is_pressed('s'):
        if keyboard.is_pressed('a'):
            client.sendto("turn -+".encode('utf-8'), (ipaddr, 9909))
            time.sleep(0.1)
        elif keyboard.is_pressed('d'):
            client.sendto("turn --".encode('utf-8'), (ipaddr, 9909))
            time.sleep(0.1)
        else:
            client.sendto("drive -".encode('utf-8'), (ipaddr, 9909))
            time.sleep(0.1)