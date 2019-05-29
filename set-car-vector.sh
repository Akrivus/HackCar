#!/bin/sh

sox ./states/"$1".wav -t wav -r 48k -b 16 - repeat 1 | nc -u 7055