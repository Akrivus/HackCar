#!/bin/sh

sox ./states/"$1$2".wav -t wav -r 48k -b 16 - repeat 1 | csdr convert_i16_f | csdr gain_ff -3 | csdr dsb_fc | sudo ../rpitx/rpitx -i - -m IQFLOAT -f 27.148e3 -s 48000
