    .global delay_loop16
    .type delay_loop16, @function

; void delay_loop16(uint16 count)
; count arrives in r24 (low), r25 (high)
delay_loop16:
    movw r30, r24       ; move count into Z register pair (r30:r31)

1:
    sbiw r30, 1         ; subtract immediate from r31:r30
    brne 1b             ; branch until zero
    ret
