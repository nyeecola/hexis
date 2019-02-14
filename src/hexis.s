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
.type did_hit_something, %function
@parameters: x_offset y_offset
did_hit_something:
    push {r1-r7, lr}

    mov r2, r0                      @ x_offset
    mov r7, r1                      @ y_offset

    ldr r4, =active_block_position

    mov r3, #1
    ldrsb r0, [r4,r3]               @ Loads X
    mov r3, #0
    ldrsb r1, [r4,r3]               @ Loads Y

    push {r0-r2}
    ldr r4, =hexis_array
    ldr r1, =active_block_type
    ldrb r1, [r1]
    ldr r2, =active_block_rotation
    ldrb r2, [r2]
    mov r3, #4*16                   @ each block has 4 rotations with 16 bytes each
    mul r1, r3
    mov r3, #16
    mul r2, r3
    add r4, r1
    add r4, r2
    pop {r0-r2}

    mov r6, #0                      @ X offset
    mov r5, #0                      @ loop index
collision_loop:
    ldrb r3, [r4, r5]               @ loads which color to draw (color index in palette)
    add r5, #1
    cmp r3, #2
    beq skip_hit_test
    add r0, r6

    push {r0-r7}
    cmp r7, #0                      @ if falling
    beq skip_ground_check
    cmp r1, #0
    beq did_hit
skip_ground_check:
    cmp r2, #1
    bne skip_right_check
    cmp r0, #9
    beq did_hit
skip_right_check:
    mov r6, #1
    neg r6, r6
    cmp r2, r6
    bne skip_left_check
    cmp r0, #0
    beq did_hit
skip_left_check:

    add r0, r2                      @ x_offset
    add r1, r7                      @ y_offset

    mov r4, #10
    mul r4, r1
    add r4, r0                      @ 10*y + x
    ldr r2, =hexis_grid
    ldrb r3, [r2, r4]
    cmp r3, #2
    bne did_hit
    pop {r0-r7}
    
    sub r0, r6
skip_hit_test:
    add r6, #1
    cmp r6, #4
    bne hit_skip_x_reset
    mov r6, #0
    sub r1, #1
hit_skip_x_reset:

    cmp r5, #16
    bne collision_loop

    mov r0, #0                      @ did not hit
    pop {r1-r7, pc}

did_hit:
    pop {r0-r7}
    mov r0, #1                      @ did hit
    pop {r1-r7, pc}


.thumb_func
.type fix_to_grid, %function
fix_to_grid:
    push {r0-r7, lr}

    ldr r2, =active_block_position

    mov r3, #1
    ldrsb r0, [r2,r3]               @ Loads X
    mov r3, #0
    ldrsb r1, [r2,r3]               @ Loads Y

    push {r0-r2}
    ldr r4, =hexis_array
    ldr r1, =active_block_type
    ldrb r1, [r1]
    ldr r2, =active_block_rotation
    ldrb r2, [r2]
    mov r3, #4*16                   @ each block has 4 rotations with 16 bytes each
    mul r1, r3
    mov r3, #16
    mul r2, r3
    add r4, r1
    add r4, r2
    pop {r0-r2}

    mov r6, #0                      @ X offset
    mov r5, #0                      @ loop index
fix_block_loop:
    ldrb r3, [r4, r5]               @ loads which color to draw (color index in palette)
    add r5, #1
    cmp r3, #2
    beq skip_fix_test
    add r0, r6

    push {r0-r7}
    ldr r5, =hexis_grid
    mov r4, #10
    mul r4, r1
    add r4, r0                      @ 10*y + x
    strb r3, [r5,r4]                @ Stores block on grid
    pop {r0-r7}
    
    sub r0, r6
skip_fix_test:
    add r6, #1
    cmp r6, #4
    bne fix_skip_x_reset
    mov r6, #0
    sub r1, #1
fix_skip_x_reset:

    cmp r5, #16
    bne fix_block_loop

    ldrh r1, =0x0516
    strh r1, [r2]                   @ reset active block position
    ldr r1, =active_block_type
    push {r0}
    push {r1}
    ldr r0, =random_word
    bl xorshift32
    lsr r0, #29
    cmp r0, #7
    bne skip_hack
    mov r0, #0
skip_hack:
    pop {r1}
    strb r0, [r1]
    pop {r0}

    pop {r0-r7, pc}


.thumb_func
.type do_game_cycle, %function
do_game_cycle:
    push {r0-r5, lr}

    mov timer, #0                   @ Resets timer
    ldr r0, =active_block_position
    mov r3, #0
    ldrsb r1, [r0,r3]               @ Y pos
    mov r3, #1
    ldrsb r2, [r0,r3]               @ X pos
    ldr r3, =hexis_grid

    push {r0, r1}
    mov r0, #0
    mov r1, #1
    neg r1, r1
    bl did_hit_something
    cmp r0, #0 
    pop {r0, r1}
    bne skip_gravity

    sub r1, #1                      @remove 1 from Y pos
    strb r1, [r0]                   @Updates ram
    b end_cycle                     @ Block can fall farther, so skips fix_to_grid

skip_gravity:
    bl fix_to_grid

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
    pop {r0-r5, pc}
