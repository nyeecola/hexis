    .text
    .thumb_func
    .type	xorshift32, %function
xorshift32:
    push {r1-r3}
    ldr	r1, [r0]
    mov r3, r1
    lsl	r3, #13
    mov r2, r1
    eor	r3, r2
    lsr	r3, #17
    mov r2, r1
    eor	r3, r2
    lsl	r3, #5
    mov r2, r1
    eor	r3, r2
    str	r3, [r0]
    mov	r0, r3
    pop {r1-r3}
    bx lr
