.section .iwram, "ax", %progbits
.align 2
.arm
@ Acknowledges the VBlank interrupt
interrupt:
    mov r1, #1

    mov r0, #0x4000000
    add r0, #0x200
    add r0, #0x2                @User IF
    strh r1, [r0]

    ldr r0, =0x3007FF8          @BIOS IF
    strh r1, [r0]

    bx lr

.text
.align 2
.thumb_func
.type enable_vblank_interrupt, %function
enable_vblank_interrupt:
    push { r0, r1 }

    mov r0, #0x4
    lsl r0, #16
    add r0, #0x2
    lsl r0, #8
    add r0, #0x8                    @IME master interrupt register
    mov r1, #1
    str r1, [r0]                    @Enables interrupts

    mov r0, #0x4
    lsl r0, #16
    add r0, #0x2
    lsl r0, #8                      @IE enabled interrupt register
    mov r1, #1
    strh r1, [r0]                   @Enable VBlank interrupt

    mov r0, #0x4
    lsl r0, #24
    add r0, #4                      @DISPSTAT reg
    mov r1, #1
    lsl r1, #3
    strh r1, [r0]                   @Also has to enable VBlank interrupt here

    ldr r0, =0x3007FFC
    ldr r1, =interrupt
    str r1, [r0]                    @Loads a pointer to the interrupt handler in the address the BIOS looks for

    pop { r0, r1 }
    bx lr
