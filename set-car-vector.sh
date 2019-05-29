#!/bin/sh

cat ./states/"$1".wav | nc -u 127.0.0.1 6996 -