.include "src/interrupt.s"
.include "src/dma.s"
.include "src/sprite.s"
.include "src/background.s"
.include "src/hexis.s"

.include "src/bg0.s"

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

    mov r0, #1
    mov r1, #4
    mov r2, #4
    bl fill_block
    mov r0, #0
    mov r1, #3
    mov r2, #4
    bl fill_block
    
    

forever:

    @ read input

    mov r0, #0x4                    @r0 = KEYINPUT
    lsl r0, #24
    mov r1, #0x13
    lsl r1, #4
    add r0, r1
    ldr r0, [r0]                    @Load user input
    mvn r0, r0                      @Makes pressed button = 1 (default is = 0)

input.start:
input.right:
    mov r1, #1
    lsl r1, #4
    and r1, r0                      @and "right" bit is set
    cmp r1, #0
    beq input.left
    @ handle right pressed here

input.left:
    mov r1, #1
    lsl r1, #5
    and r1, r0                      @and "left" bit is set
    cmp r1, #0
    beq input.up
    @ handle left pressed here

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

input.end:

    swi 0x5                         @Asks BIOS to wait for VBlank

    b forever

.section .iwram
.align 2
sprite_rotate:
    .hword 0b100000000              @X scale (8bit fractional part)
    .hword 0b100000000              @Y scale (8bit fractional part)
    .hword 0x0                      @angle
