.text
.thumb
game_main:
    mov r0, #0x4                    @Setting up BG0 with:
    lsl r0, #24
    add r0, #8
    mov r1, #0b1                    @Priority = 0; TileBase = 0; Mosaic = false; palette = 16/16; MapBase = 4; Size = 256x256
    lsl r1, #10
    strh r1, [r0]

    copy_256x256_bg bg0 4 0 4 8

    mov timer, #0
    mov input_timer, #0

game_loop:
    mov r3, #FALLING_DELAY

    @ read input
    bl input_handling

    @ gravity
    add timer, #1
    cmp timer, r3                   @ When game timer reaches current maximum
    blt end_timer_handler           @ Handle a gravity frame, else skips it
    bl do_game_cycle
end_timer_handler:

    swi 0x5                         @Asks BIOS to wait for VBlank

    @ draw grid
    bl draw_grid

    @ draw active block
    bl draw_active_block

    b game_loop
