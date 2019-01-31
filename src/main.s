.include "src/interrupt.s"
.include "src/dma.s"
.include "src/sprite.s"
.include "src/background.s"
.include "src/hexis.s"

.include "src/bg0.s"

.set INPUT_DELAY, 4
.set FALLING_DELAY, 30

input_timer .req r6
timer .req r7

.text
.align 2
.thumb_func
.global main
.type main, %function
main:
    mov r0, #0x4                    @Display Controller reg
    lsl r0, #24
    mov r1, #0b1000101              @Mode 0 + BG0 enabled + OBJ enabled + 1D OBJ mapping
    lsl r1, #6
    strh r1, [r0]

    mov r0, #0x4                    @Setting up BG0 with:
    lsl r0, #24
    add r0, #8
    mov r1, #0b1                    @Priority = 0; TileBase = 0; Mosaic = false; palette = 16/16; MapBase = 4; Size = 256x256
    lsl r1, #10
    strh r1, [r0]

    bl enable_vblank_interrupt

    copy_256x256_bg bg0 4*8 0 4

    mov timer, #0
    mov input_timer, #0

forever:
    mov r3, #FALLING_DELAY

    @ read input

    mov r0, #0x4                    @r0 = KEYINPUT
    lsl r0, #24
    mov r1, #0x13
    lsl r1, #4
    add r0, r1
    ldr r0, [r0]                    @Load user input
    mvn r0, r0                      @Makes pressed button = 1 (default is = 0)

input.start:
    cmp input_timer, #0             @If the input delay timer is zero
    beq input.right                 @Accepts a new input
    sub input_timer, #1             @Else, count one more frame and ignore input
    b input.end

input.right:
    mov r1, #1
    lsl r1, #4
    and r1, r0                      @If "right" bit is set
    cmp r1, #0
    beq input.left
    @ handle right pressed here

    ldr r2, =active_block_position
    ldrb r1, [r2,#1]                @ Loads X
    cmp r1, #9                      @If already on the far right, ignore this input
    beq input.left

    ldrb r4, [r2]                   @ Loads Y
    mov r5, #10
    mul r4, r5
    add r4, r1
    ldr r5, =hexis_grid
    add r5, r4                      @ hexis_grid + 10 * y + x
    ldrb r5, [r5,#1]                @ Loads block to the right of current block
    cmp r5, #2                      @ If it`s not empty, ignore this input
    bne input.left

    add r1, #1                      @ If input is not ignored anywhere
    strb r1, [r2,#1]                @ Moves block right and stores it back to ram
    mov input_timer, #INPUT_DELAY   @Valid input increases the input delay timer

input.left:
    mov r1, #1
    lsl r1, #5
    and r1, r0                      @If "left" bit is set
    cmp r1, #0
    beq input.up
    @ handle left pressed here

    ldr r2, =active_block_position
    ldrb r1, [r2,#1]                @ Loads X
    cmp r1, #0                      @If already on the far left, ignore this input
    beq input.up

    ldrb r4, [r2]                   @ Loads Y
    mov r5, #10
    mul r4, r5
    add r4, r1
    ldr r5, =hexis_grid
    add r5, r4                      @ hexis_grid + 10 * y + x
    sub r5, #1
    ldrb r5, [r5]                   @ Loads block to the left of current block
    cmp r5, #2                      @If it`s not empty, ignore this input
    bne input.up

    sub r1, #1                      @if input is not ignored anywhere
    strb r1, [r2,#1]                @moves block left and stores it back to ram
    mov input_timer, #INPUT_DELAY   @Valid input increases the input delay timer

input.up:
    mov r1, #1
    lsl r1, #6
    and r1, r0                      @If "up" bit is set
    cmp r1, #0
    beq input.down
    @ handle up pressed here

input.down:
    mov r1, #1
    lsl r1, #7
    and r1, r0                      @If "down" bit is set
    cmp r1, #0
    beq input.end
    @ handle down pressed here

    mov r3, #2                      @Cuts down game timer, making blocks fall faster
    @ purposefully not adding input delay

input.end:

    @ gravity

    add timer, #1
    cmp timer, r3                   @ When game timer reaches current maximum
    blt end_timer_handler           @ Handle a gravity frame, else skips it

    mov timer, #0                   @ Resets timer
    ldr r0, =active_block_position
    ldrb r1, [r0]                   @ Y pos
    ldrb r2, [r0,#1]                @ X pos
    ldr r3, =hexis_grid

    cmp r1, #0                      @ if got to the bottom of the screen
    beq fix_to_grid                 @ fixes active block to grid

    mov r4, #10
    mul r4, r1
    sub r4, #10
    add r4, r2                      @ 10 * (y-1) + x
    ldrb r4, [r3,r4]                @ load tile under the active block
    cmp r4, #2                      @ if tile is not empty
    bne fix_to_grid                 @ fixes active block to grid

    sub r1, #1                      @remove 1 from Y pos
    strb r1, [r0]                   @Updates ram
    b end_timer_handler             @ Block can fall farther, so skips fix_to_grid

fix_to_grid:
    mov r4, #10
    mul r4, r1
    add r4, r2
    mov r1, #3                      @ 10*y + x
    strb r1, [r3,r4]                @ Stores block on grid
    ldrh r1, =0x0516
    strh r1, [r0]                   @ reset active block position

    @ check if any lines were cleared

    ldr r0, =hexis_grid
    mov r4, r0                      @ Y (line address)
    add r0, #200                    @ Max address
    mov r1, #0                      @ keeps count of lines cleared

line_loop:
    mov r5, #0                      @ byte index
byte_loop:
    ldrb r3, [r4, r5]               @ loads current byte in the line
    add r5, #1                      @ next byte for the following iteration
    cmp r3, #2                      @ if byte is black, this line should drop down
    beq drop_line                   @   as it cannot be cleared
    cmp r5, #10                     @ if in end of line
    bne byte_loop
    add r1, #1                      @ this line has no black, so it should be cleared
    b   end_byte_loop

drop_line:
    mov r5, #10
    mul r5, r1
    sub r5, r4
    neg r5, r5                      @ dest = current_line_addr - lines_cleared * 10
    ldrb r2, [r4, #0]               @ copies the whole current line to the destination
    strb r2, [r5, #0]
    ldrb r2, [r4, #1]
    strb r2, [r5, #1]
    ldrb r2, [r4, #2]
    strb r2, [r5, #2]
    ldrb r2, [r4, #3]
    strb r2, [r5, #3]
    ldrb r2, [r4, #4]
    strb r2, [r5, #4]
    ldrb r2, [r4, #5]
    strb r2, [r5, #5]
    ldrb r2, [r4, #6]
    strb r2, [r5, #6]
    ldrb r2, [r4, #7]
    strb r2, [r5, #7]
    ldrb r2, [r4, #8]
    strb r2, [r5, #8]
    ldrb r2, [r4, #9]
    strb r2, [r5, #9]
end_byte_loop:

    add r4, #10                     @ Goes to the next line
    cmp r4, r0                      @ Unless it has reached the end of the grid
    blt line_loop
end_timer_handler:

    swi 0x5                         @Asks BIOS to wait for VBlank

    @ draw grid

    ldr r0, =hexis_grid
    mov r1, #0                      @ X
    mov r2, #0                      @ Y
begin_draw_grid:
    cmp r2, #20                     @ If has drawed all 20 lines
    beq end_draw_grid               @ Finished drawing

    mov r3, #10
    mul r3, r2
    add r3, r1
    add r3, r0                      @ hexis_grid + 10 * y + x
    ldrb r3, [r3]                   @ Loads color from current grid position
    push {r0-r2}
    mov r0, r1                      @ X
    mov r1, r2                      @ Y
    mov r2, #4                      @ Mapbase 4
    bl fill_block                   @ Fills block on screen
    pop {r0-r2}

    add r1, #1                      @ Increments X
    cmp r1, #10                     @ If hasn`t finished line
    bne begin_draw_grid             @ Goes to next X
    mov r1, #0                      @ Resets X
    add r2, #1                      @ Goes to next line
    b begin_draw_grid
end_draw_grid:

    @ draw active block

    ldr r2, =active_block_position
    ldrb r0, [r2,#1]                @ Loads X
    ldrb r1, [r2]                   @ Loads Y
    mov r2, #4                      @ Mapbase 4
    mov r3, #3                      @ Red
    bl fill_block                   @ Fills active block on screen

    b forever

.section .iwram
.align 2
active_block_position:
    .hword 0x0516                      @ first byte is X, second byte is Y
.align 2
hexis_grid:
    .fill 22*10,1,2                    @Each byte is a grit pallete to be draw
