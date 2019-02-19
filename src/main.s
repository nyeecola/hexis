input_timer .req r6
timer .req r7

.include "src/interrupt.s"
.include "src/dma.s"
.include "src/background.s"
.include "src/hexis.s"
.include "src/input.s"
.include "src/draw.s"
.include "src/prng.s"
.include "src/game-main.s"
.include "src/title-main.s"

.include "src/bg/field.s"
.include "src/bg/title.s"
.include "src/bg/hud.s"

.set INPUT_DELAY, 4
.set ROTATION_DELAY, 14
.set FALLING_DELAY, 30
.set SOFTDROP_DELAY, 2
.set HIGH_SCORE, 0x0E000000

.text
.align 2
.thumb_func
.global main
.type main, %function
main:
    mov r0, sp                      @Store beginning of stack
    mov r12, r0

    mov r0, #0x4                    @Display Controller reg
    lsl r0, #24
    mov r1, #0b1001101              @Mode 0 + BG0 enabled + BG1 enabled + OBJ enabled + 1D OBJ mapping
    lsl r1, #6
    strh r1, [r0]

    bl enable_vblank_interrupt

    ldr r0, =HIGH_SCORE
    ldrb r1, [r0]
    cmp r1, #0xBB
    beq reset_game
reset_save:
    mov r1, #0xBB
    strb r1, [r0]
    mov r1, #0
    strb r1, [r0, #1]
    strb r1, [r0, #2]
    strb r1, [r0, #3]
    strb r1, [r0, #4]

reset_game:
    ldr r0, =hexis_grid_zeroed
    ldr r1, =hexis_grid
    mov r2, #55
    bl dma3_copy

    ldr r0, =lines_cleared
    mov r1, #0
    str r1, [r0]

    ldr r0, =score
    str r1, [r0]

    bl title_main
    b game_main

.section .iwram
.align 2
active_block_position:
    .hword 0x0416                      @ first byte is Y, second byte is X
active_block_type:
    .byte 2
active_block_rotation:
    .byte 0

random_word:
    .word 0xfa28e0b1

lines_cleared:
    .word 0x0

score:
    .word 0x0

available_blocks:
    .byte 1,1,1,1,1,1,1

.align 2
hexis_grid:
    .fill 22*10,1,2                    @Each byte is a grit pallete to be draw

.align 2
hexis_grid_zeroed:
    .fill 22*10,1,2                    @Each byte is a grit pallete to be draw


.align 2
hexis_array:
    .byte 2,2,2,2
    .byte 2,3,3,2
    .byte 2,3,3,2
    .byte 2,2,2,2

    .byte 2,2,2,2
    .byte 2,3,3,2
    .byte 2,3,3,2
    .byte 2,2,2,2

    .byte 2,2,2,2
    .byte 2,3,3,2
    .byte 2,3,3,2
    .byte 2,2,2,2

    .byte 2,2,2,2
    .byte 2,3,3,2
    .byte 2,3,3,2
    .byte 2,2,2,2


    .byte 2,2,2,2
    .byte 4,4,4,4
    .byte 2,2,2,2
    .byte 2,2,2,2

    .byte 2,2,4,2
    .byte 2,2,4,2
    .byte 2,2,4,2
    .byte 2,2,4,2

    .byte 2,2,2,2
    .byte 2,2,2,2
    .byte 4,4,4,4
    .byte 2,2,2,2

    .byte 2,4,2,2
    .byte 2,4,2,2
    .byte 2,4,2,2
    .byte 2,4,2,2


    .byte 2,5,2,2
    .byte 5,5,5,2
    .byte 2,2,2,2
    .byte 2,2,2,2

    .byte 2,5,2,2
    .byte 2,5,5,2
    .byte 2,5,2,2
    .byte 2,2,2,2

    .byte 2,2,2,2
    .byte 5,5,5,2
    .byte 2,5,2,2
    .byte 2,2,2,2

    .byte 2,5,2,2
    .byte 5,5,2,2
    .byte 2,5,2,2
    .byte 2,2,2,2


    .byte 2,2,6,2
    .byte 6,6,6,2
    .byte 2,2,2,2
    .byte 2,2,2,2

    .byte 2,6,2,2
    .byte 2,6,2,2
    .byte 2,6,6,2
    .byte 2,2,2,2

    .byte 2,2,2,2
    .byte 6,6,6,2
    .byte 6,2,2,2
    .byte 2,2,2,2

    .byte 6,6,2,2
    .byte 2,6,2,2
    .byte 2,6,2,2
    .byte 2,2,2,2


    .byte 2,7,2,2
    .byte 2,7,2,2
    .byte 7,7,2,2
    .byte 2,2,2,2

    .byte 7,2,2,2
    .byte 7,7,7,2
    .byte 2,2,2,2
    .byte 2,2,2,2

    .byte 2,7,7,2
    .byte 2,7,2,2
    .byte 2,7,2,2
    .byte 2,2,2,2

    .byte 2,2,2,2
    .byte 7,7,7,2
    .byte 2,2,7,2
    .byte 2,2,2,2


    .byte 2,8,8,2
    .byte 8,8,2,2
    .byte 2,2,2,2
    .byte 2,2,2,2

    .byte 2,8,2,2
    .byte 2,8,8,2
    .byte 2,2,8,2
    .byte 2,2,2,2

    .byte 2,2,2,2
    .byte 2,8,8,2
    .byte 8,8,2,2
    .byte 2,2,2,2

    .byte 8,2,2,2
    .byte 8,8,2,2
    .byte 2,8,2,2
    .byte 2,2,2,2


    .byte 9,9,2,2
    .byte 2,9,9,2
    .byte 2,2,2,2
    .byte 2,2,2,2

    .byte 2,2,9,2
    .byte 2,9,9,2
    .byte 2,9,2,2
    .byte 2,2,2,2

    .byte 2,2,2,2
    .byte 9,9,2,2
    .byte 2,9,9,2
    .byte 2,2,2,2

    .byte 2,9,2,2
    .byte 9,9,2,2
    .byte 9,2,2,2
    .byte 2,2,2,2
