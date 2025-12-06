package avr_delay

// Odin port of https://github.com/avr-rust/delay

foreign import delay_loop "delay_loop.o"

foreign delay_loop {
    delay_loop16 :: proc(count: u16) ---
}

CPU_FREQ :: 16000000

delay :: proc "c" (count: u64) {
    outer_count := count / 65536
    last_count := u16(count % 65536 + 1)

    for _ in 0 ..< outer_count {
        delay_loop16(0)    // zero means 65536 loops in AVR sbiw semantics
    }

    delay_loop16(last_count)
}

delay_us :: proc "c" (us: u64) {
    us_in_loop : u64 = (CPU_FREQ / 1_000_000 / 4)
    loops := us * us_in_loop
    delay(loops)
}

delay_ms :: proc "c" (ms: u64) {
    delay_us(ms * 1_000)
}
