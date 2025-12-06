#!/usr/bin/env bash

./odin build demo -target:freestanding_avr -microarch:atmega328p -build-mode:obj -disable-assert -no-bounds-check -no-type-assert -no-crt -o:size
avr-gcc -mmcu=atmega328p demo.o demo/avr_delay/delay_loop.o -lgcc -lm -o demo.elf
avr-objcopy -O ihex demo.elf demo.hex
avrdude -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -U flash:w:demo.hex