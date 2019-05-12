import keyboard
import socket
import time

ipaddr = (input("Enter IP address: "), 9909)
client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client.settimeout(1)
client.sendto(b"brake !", ipaddr)
sleep_time = 0.1

while 1 > 0:
    if keyboard.is_pressed('space'):
        client.sendto(b"brake !", ipaddr)
        time.sleep(sleep_time)
    elif keyboard.is_pressed('w'):
        client.sendto(b"drive +", ipaddr)
        time.sleep(sleep_time)
    elif keyboard.is_pressed('a'):
        client.sendto(b"turn ++", ipaddr)
        time.sleep(sleep_time)
    elif keyboard.is_pressed('d'):
        client.sendto(b"turn +-", ipaddr)
        time.sleep(sleep_time)
    elif keyboard.is_pressed('s'):
        client.sendto(b"drive -", ipaddr)
        time.sleep(sleep_time)
    elif keyboard.is_pressed('q'):
        client.sendto(b"turn -+", ipaddr)
        time.sleep(sleep_time)
    elif keyboard.is_pressed('e'):
        client.sendto(b"turn --", ipaddr)
        time.sleep(sleep_time)