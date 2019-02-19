    .text
    .thumb_func
    .type xorshift32, %function
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

    .thumb_func
    .type check_available_blocks, %function
check_available_blocks:
    push {r0-r1}

    ldr r0, =available_blocks
    ldrb r1, [r0]
    cmp r1, #1
    beq skip_available_blocks_reset

    ldrb r1, [r0, #1]
    cmp r1, #1
    beq skip_available_blocks_reset

    ldrb r1, [r0, #2]
    cmp r1, #1
    beq skip_available_blocks_reset

    ldrb r1, [r0, #3]
    cmp r1, #1
    beq skip_available_blocks_reset

    ldrb r1, [r0, #4]
    cmp r1, #1
    beq skip_available_blocks_reset

    ldrb r1, [r0, #5]
    cmp r1, #1
    beq skip_available_blocks_reset

    ldrb r1, [r0, #6]
    cmp r1, #1
    beq skip_available_blocks_reset
available_blocks_reset:
    mov r1, #1
    strb r1, [r0]
    strb r1, [r0, #1]
    strb r1, [r0, #2]
    strb r1, [r0, #3]
    strb r1, [r0, #4]
    strb r1, [r0, #5]
    strb r1, [r0, #6]

skip_available_blocks_reset:
    pop {r0-r1}
    bx lr

.ltorg
