.text
.thumb_func
.type title_main, %function
title_main:
    push {lr}

    mov r0, #0x4                    @Setting up BG0 with:
    lsl r0, #24
    add r0, #8
    ldr r1, =0b0000000010000100     @Priority = 0; TileBase = 1; Mosaic = false; palette = 256; MapBase = 0; Size = 256x256
    strh r1, [r0]

    copy_256x256_bg_8bbp title 146 1 0 16

    mov r2, #0

title_loop:
    mov r0, #0x4                    @r0 = KEYINPUT
    lsl r0, #24
    mov r1, #0x13
    lsl r1, #4
    add r0, r1
    ldr r0, [r0]                    @Load user input
    mvn r0, r0                      @Makes pressed button = 1 (default is = 0)

    mov r1, #1
    lsl r1, #3
    and r1, r0                      @If "start" bit is set
    cmp r1, #0
    bne break_title_loop

    add r2, #1

    push {r2}
    swi 0x5                         @Asks BIOS to wait for VBlank
    pop {r2}

    b title_loop
break_title_loop:
    mov r3, r2
    lsl r3, #2
    mul r2, r3
    lsl r3, #2
    mul r2, r3

    ldr r3, =random_word
    add r2, r3
    str r2, [r3]

    bl generate_random_type

    ldr r1, =active_block_type
    strb r0, [r1]

    ldr r1, =next_block_types
    bl generate_random_type
    strb r0, [r1]
    bl generate_random_type
    strb r0, [r1, #1]
    bl generate_random_type
    strb r0, [r1, #2]
    bl generate_random_type
    strb r0, [r1, #3]

    bl update_next_sprites

    pop {pc}
.ltorg
