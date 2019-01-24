@ r0 -> src
@ r1 -> dest
@ r2 -> size
.text
.thumb_func
.type dma3_copy, %function
dma3_copy:
    push { r3 }

    mov r3, #0x4
    lsl r3, #24
    add r3, #0xD4                   @DMA3 source
    str r0, [r3]

    mov r3, #0x4
    lsl r3, #24                     @DMA3 destination
    add r3, #0xD8
    str r1, [r3]

    mov r3, #0x4
    lsl r3, #24                     @DMA3 word count
    add r3, #0xDC
    strh r2, [r3]

    mov r3, #0x4
    lsl r3, #24                     @DMA3 control reg
    add r3, #0xDE
    mov r1, #0b100001
    lsl r1, #10                     @Increment src and dest addr; no repeat; tranfer type = 32bits; start immediately; won't cause an IRQ; enables channel
    strh r1, [r3]

    pop { r3 }
    bx lr
