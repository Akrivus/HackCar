import keyboard
import socket
import time

ipaddr = (input("Enter IP address: "), 9909)
client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client.settimeout(1)
client.sendto(b"brake !", ipaddr)

while 1 > 0:
    if keyboard.is_pressed('w'):
        if keyboard.is_pressed('a'):
            client.sendto(b"turn ++", ipaddr)
            time.sleep(0.1)
        elif keyboard.is_pressed('d'):
            client.sendto(b"turn +-", ipaddr)
            time.sleep(0.1)
        else:
            client.sendto(b"drive +", ipaddr)
            time.sleep(0.1)
    elif keyboard.is_pressed('s'):
        if keyboard.is_pressed('a'):
            client.sendto(b"turn -+", ipaddr)
            time.sleep(0.1)
        elif keyboard.is_pressed('d'):
            client.sendto(b"turn --", ipaddr)
            time.sleep(0.1)
        else:
            client.sendto(b"drive -", ipaddr)
            time.sleep(0.1)