import socket
import time

ipaddr = (input("Enter IP address: "), 9909)
client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client.settimeout(1)
sleep_time = 0.5

while 1 > 0:
    client.sendto(b"drive +", ipaddr)
    time.sleep(sleep_time)
    client.sendto(b"drive -", ipaddr)
    time.sleep(sleep_time)