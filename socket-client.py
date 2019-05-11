import keyboard
import socket

ipaddr = input("Enter IP address: ")
client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

while 1 > 0:
    if keyboard.is_pressed('w'):
        if keyboard.is_pressed('a'):
            client.sendto('turn ++', (ipaddr, 4404))
        elif keyboard.is_pressed('d'):
            client.sendto('turn +-', (ipaddr, 4404))
        else:
            client.sendto('drive +', (ipaddr, 4404))
    elif keyboard.is_pressed('s'):
        if keyboard.is_pressed('a'):
            client.sendto('turn -+', (ipaddr, 4404))
        elif keyboard.is_pressed('d'):
            client.sendto('turn --', (ipaddr, 4404))
        else:
            client.sendto('drive -', (ipaddr, 4404))