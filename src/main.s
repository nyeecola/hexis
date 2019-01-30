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

    @ TEST CODE
    mov r0, #1
    mov r1, #4
    mov r2, #4
    mov r3, #3
    bl fill_block
    mov r0, #0
    mov r1, #3
    mov r2, #4
    mov r3, #1
    bl fill_block
    
    
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
    cmp input_timer, #0
    beq input.right
    sub input_timer, #1
    b input.end

input.right:
    mov r1, #1
    lsl r1, #4
    and r1, r0                      @and "right" bit is set
    cmp r1, #0
    beq input.left
    @ handle right pressed here

    ldr r2, =active_block_position
    ldrb r1, [r2,#1]                @ X
    cmp r1, #9
    beq input.left
    ldrb r4, [r2]                   @ Y
    mov r5, #10
    mul r4, r5
    add r4, r1
    ldr r5, =hexis_grid
    add r5, r4
    ldrb r5, [r5,#1]
    cmp r5, #2
    bne input.left
    add r1, #1
    strb r1, [r2,#1]

    mov input_timer, #INPUT_DELAY

input.left:
    mov r1, #1
    lsl r1, #5
    and r1, r0                      @and "left" bit is set
    cmp r1, #0
    beq input.up
    @ handle left pressed here

    ldr r2, =active_block_position
    ldrb r1, [r2,#1]                @ X
    cmp r1, #0
    beq input.up
    ldrb r4, [r2]                   @ Y
    mov r5, #10
    mul r4, r5
    add r4, r1
    ldr r5, =hexis_grid
    add r5, r4
    sub r5, #1
    ldrb r5, [r5]
    cmp r5, #2
    bne input.up
    sub r1, #1
    strb r1, [r2,#1]

    mov input_timer, #INPUT_DELAY

input.up:
    mov r1, #1
    lsl r1, #6
    and r1, r0                      @and "up" bit is set
    cmp r1, #0
    beq input.down
    @ handle up pressed here

input.down:
    mov r1, #1
    lsl r1, #7
    and r1, r0                      @and "down" bit is set
    cmp r1, #0
    beq input.end
    @ handle down pressed here

    mov r3, #2
    @ purposefully not adding input delay

input.end:

    
    @ gravity

    add timer, #1
    cmp timer, r3
    blt skip_timer_handler
    mov timer, #0
    ldr r0, =active_block_position
    ldrb r1, [r0]                   @ Y pos
    ldrb r2, [r0,#1]                @ X pos
    ldr r3, =hexis_grid

    cmp r1, #0                      @ if got to the bottom of the screen
    beq fix_to_grid

    mov r4, #10
    mul r4, r1
    sub r4, #10
    add r4, r2
    ldrb r4, [r3,r4]                @ load tile under the active block
    cmp r4, #2                      @ if tile is empty
    bne fix_to_grid

    sub r1, #1                      @remove 1 from Y pos
    strb r1, [r0]
    b skip_timer_handler

fix_to_grid:
    mov r4, #10
    mul r4, r1
    add r4, r2
    mov r1, #3
    strb r1, [r3,r4]                @ fixed in grid
    ldrh r1, =0x0516
    strh r1, [r0]                   @ reset active block position


    @ check if any lines were cleared
    
    ldr r0, =hexis_grid
    mov r1, #0                      @ keeps count of lines cleared
    mov r4, r0                      @ Y (line address)

line_loop:
    mov r5, #0                      @ byte index
byte_loop:
    ldrb r3, [r4, r5]
    add r5, #1
    cmp r3, #2
    beq drop_line
    cmp r5, #10
    bne byte_loop
    add r1, #1                      @ line cleared
    b   end_byte_loop

drop_line:
    mov r5, #10
    mul r5, r1
    sub r5, r4
    neg r5, r5
    ldrb r2, [r4, #0]
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

    add r4, #10
    mov r2, r0
    add r2, #200
    cmp r4, r2
    blt line_loop


skip_timer_handler:

    swi 0x5                         @Asks BIOS to wait for VBlank

    @ draw grid

    ldr r0, =hexis_grid
    mov r1, #0
    mov r2, #0
begin_draw_grid:
    cmp r2, #20 
    beq end_draw_grid

    mov r3, #10
    mul r3, r2
    add r3, r1
    add r3, r0
    ldrb r3, [r3]
    push {r0-r2}
    mov r0, r1
    mov r1, r2
    mov r2, #4
    bl fill_block
    pop {r0-r2}
    
    add r1, #1
    cmp r1, #10
    bne begin_draw_grid
    mov r1, #0
    add r2, #1
    b begin_draw_grid
end_draw_grid:


    @ draw active block

    ldr r0, =active_block_position
    ldrh r0, [r0]
    mov r1, r0
    mov r2, #0xFF
    and r1, r2
    lsr r0, #8
    mov r2, #4
    mov r3, #3
    bl fill_block

    

    b forever

.section .iwram
.align 2
active_block_position:
    .hword 0x0516                      @ first byte is X, second byte is Y
.align 2
hexis_grid:
    .fill 22*10,1,2
