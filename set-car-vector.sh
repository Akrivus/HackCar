#!/bin/sh

(while true; do cat ./states/"$1$2".wav; done) | csdr convert_i16_f | csdr gain_ff -3 | csdr dsb_fc | sudo ../rpitx/rpitx -i - -m IQFLOAT -f 27.148e6 -s 48000
