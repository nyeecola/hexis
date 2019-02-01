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
    push {r0-r3, lr}

    ldr r2, =active_block_position

    ldrb r0, [r2,#1]                @ Loads X
    ldrb r1, [r2]                   @ Loads Y
    mov r2, #4                      @ Mapbase 4
    mov r3, #3                      @ Red
    bl fill_block                   @ Fills active block on screen

    pop {r0-r3, pc}
