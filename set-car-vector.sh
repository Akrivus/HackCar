#!/bin/sh

cat ./state/"$1".wav | nc -u 127.0.0.1 7055 -