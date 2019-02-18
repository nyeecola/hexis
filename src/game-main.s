.text
.thumb
game_main:
    mov r0, #0x4                    @Setting up BG0 with:
    lsl r0, #24
    add r0, #8
    ldr r1, =0b0000010000000001     @Priority = 1; TileBase = 0; Mosaic = false; palette = 16/16; MapBase = 4; Size = 256x256
    strh r1, [r0]

    mov r0, #0x4                    @Setting up BG1 with:
    lsl r0, #24
    add r0, #0xA
    ldr r1, =0b0000101000000100     @Priority = 0; TileBase = 1; Mosaic = false; Palette = 16/16; MapBase = 10; Size = 256x256
    strh r1, [r0]

    copy_256x256_bg hud 49 1 10 9
    copy_256x256_bg bg0 4 0 4 8

    mov timer, #0
    mov input_timer, #0

game_loop:
    ldr r0, =lines_cleared          @Decreasses falling speed depending on lines_cleared
    ldr r0, [r0]
    lsr r0, #3

    mov r3, #FALLING_DELAY
    sub r3, r0
    cmp r3, #SOFTDROP_DELAY
    bge skip_delay_cap              @Caps it at softdrop speed
    mov r3, #SOFTDROP_DELAY
skip_delay_cap:

    @ read input
    bl input_handling

    @ gravity
    add timer, #1
    cmp timer, r3                   @ When game timer reaches current maximum
    blt end_timer_handler           @ Handle a gravity frame, else skips it
    bl do_game_cycle
end_timer_handler:
    bl update_lines_cleared_counter
    bl update_score_counter
    bl update_hi_score_counter

    swi 0x5                         @Asks BIOS to wait for VBlank

    @ draw grid
    bl draw_grid

    @ draw active block
    bl draw_active_block

    b game_loop

.thumb_func
.type update_lines_cleared_counter, %function
update_lines_cleared_counter:
    push {r0-r5, lr}

    mov r3, #0x6
    lsl r3, #24
    mov r2, #10                     @VRAM + MapBase*0x800
    lsl r2, #11
    add r3, r2
    ldr r2, =1122
    add r2, r3
    add r2, #6

    ldr r4, =1280
    add r4, r3

    ldr r0, =lines_cleared
    ldr r0, [r0]
    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    mov r5, #64

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]

    pop {r0-r5, pc}

.thumb_func
.type update_score_counter, %function
update_score_counter:
    push {r0-r5, lr}

    mov r3, #0x6
    lsl r3, #24
    mov r2, #10                     @VRAM + MapBase*0x800
    lsl r2, #11
    add r3, r2
    ldr r2, =296
    add r2, r3
    add r2, #16

    ldr r4, =1280
    add r4, r3

    ldr r0, =score
    ldr r0, [r0]
    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    mov r5, #64

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]

    pop {r0-r5, pc}

.thumb_func
.type update_hi_score_counter, %function
update_hi_score_counter:
    push {r0-r5, lr}

    mov r3, #0x6
    lsl r3, #24
    mov r2, #10                     @VRAM + MapBase*0x800
    lsl r2, #11
    add r3, r2
    ldr r2, =168
    add r2, r3
    add r2, #16

    ldr r4, =1280
    add r4, r3

    push {r1-r4}
    ldr r0, =HIGH_SCORE
    ldrb r3, [r0, #1]
    lsl r3, #8
    ldrb r1, [r0, #2]
    orr r3, r1
    lsl r3, #8
    ldrb r1, [r0, #3]
    orr r3, r1
    lsl r3, #8
    ldrb r1, [r0, #4]
    orr r3, r1
    mov r0, r3
    pop {r1-r4}

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    mov r5, #64

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]
    sub r2, #2

    mov r1, #10
    swi 0x6
    lsl r1, #1
    add r1, r4

    ldrh r3, [r1]
    strh r3, [r2]
    ldrh r3, [r1, r5]
    strh r3, [r2, r5]

    pop {r0-r5, pc}
