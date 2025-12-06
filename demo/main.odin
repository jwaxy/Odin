package demo

import "base:intrinsics"
import "avr_delay"

delay :: avr_delay.delay_ms

// AVR ATmega328P registers for Pin 13 (Port B, bit 5)
DDRB  :: cast(^u8)cast(uintptr)0x24   // Data Direction Register
PORTB :: cast(^u8)cast(uintptr)0x25   // Port B output register

//delay :: proc "c" () {
//    for i: u32 = 0; i < 500_000; i += 1 {
//        intrinsics.cpu_relax() // Prevent optimization of the for loop
//    }
//}

@(link_name="main", linkage="strong", require, export)
main :: proc "c" () {
// Set Pin 13 (PB5) as output
    intrinsics.volatile_store(DDRB, 0x20)  // Binary: 00100000 (bit 5 = pin 13)

    // Blink forever
    for {
        intrinsics.volatile_store(PORTB, 0x20)  // Turn LED ON
        delay(1000)

        intrinsics.volatile_store(PORTB, 0x00)  // Turn LED OFF
        delay(1000)
    }
}