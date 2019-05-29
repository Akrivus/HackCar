#!/bin/sh

sox -m ./states/"$1".wav ./states/"$2".wav -t wav -r 48k -b 16 - repeat 1 | csdr convert_i16_f | csdr gain_ff 1 | csdr dsb_fc | sudo ../rpitx/rpitx -i - -m IQFLOAT -f 27.145e3 -s 48000