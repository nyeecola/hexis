.text
.align 2
.thumb_func
.type fill_block, %function
fill_block:
    @ this functions assumes palette 0 is the one used for the given map base
    @ parameters: x y mapbase color
    @ color must be one of the following:
    @ - 2 for black/empty
    @ - 3 for red
    @ - 4 for blue
    @ - 5 for green
    @ - 6 for magenta
    @ - 7 for cyan
    @ - 8 for yellow
    @ - 9 for white
    push { r5 }

    @ convert block x and y to map x and y
    add r0, #6
    mov r5, #19
    sub r5, r1
    mov r1, r5

    @ get mapbase address on VRAM
    mov r5, #0x6
    lsl r5, #24
    lsl r2, #11
    add r5, r2

    @ changes the tile type in the mapbase
    lsl r1, #5
    add r1, r0
    lsl r1, #1
    add r5, r1
    strh r3, [r5]

    pop { r5 }

    bx lr

.thumb_func
.type do_game_cycle, %function
do_game_cycle:
    push {r0-r5}

    mov timer, #0                   @ Resets timer
    ldr r0, =active_block_position
    mov r3, #0
    ldrsb r1, [r0,r3]               @ Y pos
    mov r3, #1
    ldrsb r2, [r0,r3]               @ X pos
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
    b end_cycle                     @ Block can fall farther, so skips fix_to_grid

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
end_cycle:
    pop {r0-r5}
    bx lr
