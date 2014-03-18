#!/bin/bash

#mpost lithium.mp; latex lithium.tex; dvipdf lithium.dvi; dvips lithium.dvi -o lithium.eps

rm lithium.1 lithium.aux lithium.eps lithium.log mpx* 

mpost lithium.mp; latex lithium.tex; dvips lithium.dvi -o lithium.eps

ps2eps -f lithium.eps
mv lithium.eps.eps lithium.eps
epstopdf lithium.eps
