# HackCar

HackCar is a library that allows a Raspberry Pi to interface with a remote control car and control it from a remote device via WASD over UDP. It is designed to be expandable, and serves as a single component in a larger system.

## Parameters

In setup the following was used:

* Raspberry Pi Zero W with Raspian Stretch Lite and RPiTX installed.
* Copper whip antenna used for transmission.
* Telescopic antenna with stand for better transmission (transmitting on RCRS requires a long, vertical antenna for ideal reception, without it, we had spots where the radio signal kind of just "jumped" over the receiver.)
* JM Manufacturing (HK) Ltd. 1/24 New Race Car and Controller.

Estimated budget: $30?
(spent closer to $10 for the Pi + SD card + car.)

## Setup

* Verify parameters, clone repository.
* On the Pi, go the repository folder and run `sudo python3 socket-server.py`.
* Press enter when asked for an IP address, Linux accepts blank IPs.
* On the client, run `sudo python3 socket-client.py`.
* Enter the Pi's IP address when it asks.
* Use WASD to control the car.

Please note the client doesn't check if the terminal is open, so it will detect any keys being pressed while the client is running.

## Challenges

* Do tricks (donuts on a table, etc.)
* USB rechargable (not hard.)
* Find waypoints and do pathfinding via GPS, IR, etc.
* Go to charging stations automatically.
* Track your feet and follow you around.
* Find and deliver physical items.