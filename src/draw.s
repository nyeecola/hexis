.text
.align 2
.thumb_func
.type draw_grid, %function
draw_grid:
    push {r0-r3, lr}

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
    pop {r0-r3, pc}

.thumb_func
.type draw_active_block, %function
draw_active_block:
    push {r0-r6, lr}

    ldr r2, =active_block_position

    mov r3, #1
    ldrsb r0, [r2,r3]               @ Loads X
    mov r3, #0
    ldrsb r1, [r2,r3]               @ Loads Y

    push {r0-r1}
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
    pop {r0-r1}

    mov r6, #0                      @ X offset
    mov r5, #0                      @ loop index
block_drawing_loop:
    ldrb r3, [r4, r5]               @ loads which color to draw (color index in palette)
    add r5, #1
    cmp r3, #2
    beq skip_drawing
    mov r2, #4                      @ Mapbase 4
    add r0, r6
    push {r0-r7}
    bl fill_block                   @ Fills active block on screen
    pop {r0-r7}

    sub r0, r6
skip_drawing:
    add r6, #1
    cmp r6, #4
    bne skip_x_reset
    mov r6, #0
    sub r1, #1
skip_x_reset:

    cmp r5, #16
    bne block_drawing_loop

    pop {r0-r6, pc}
.ltorg

.thumb_func
.type clear_animation, %function
clear_animation:
    @ r5 -> destination line
    push {r0-r4, lr}

    mov r0, #1
    mov r1, r5
    mov r2, r5

    add r1, #4
    add r2, #5

    mov r3, #2
clear_animation_loop:
    mov r4, #0
    add r4, r1
    add r4, r0
    strb r3, [r4]

    mov r4, #0
    add r4, r2
    sub r4, r0
    strb r3, [r4]

    push {r0-r4}
    swi 0x5
    swi 0x5
    pop {r0-r4}

    @ draw grid
    bl draw_grid

    @ draw active block
    bl draw_active_block

    add r0, #1
    cmp r0, #5
    ble clear_animation_loop

    pop {r0-r4, pc}
