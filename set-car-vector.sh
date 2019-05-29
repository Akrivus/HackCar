#!/bin/sh

cat ./states/"$1".wav | nc -q0 -u 127.0.0.1 6996 -