.text
.align 2
.thumb_func
.type fill_block, %function
fill_block:
    @ parameters: x y mapbase
    push { r3 }

    add r0, #6
    mov r3, #19
    sub r3, r1
    mov r1, r3

    mov r3, #0x6
    lsl r3, #24
    lsl r2, #11
    add r3, r2

    lsl r1, #5
    add r1, r0
    lsl r1, #1
    add r3, r1

    mov r0, #3
    strh r0, [r3]

    pop { r3 }

    bx lr
    
