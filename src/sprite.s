.text

@ Copies GRIT generated data to vram
.macro copy_64x64_sprite name tilebase palette
    push { r0-r2 }

    ldr r0, =\name\()Tiles
    mov r1, #0x6
    lsl r1, #8
    add r1, #0x1                    @OBJ tile vram location
    lsl r1, #16
    mov r2, #\tilebase
    lsl r2, #5                      @Tile base 1 -> 32 bytes offset
    add r1, r2
    mov r2, #1
    lsl r2, #9                      @64x64 sprite is 8x8 tiles -> 64 tiles * 8 word per tile
    bl dma3_copy

    ldr r0, =\name\()Pal
    mov r1, #0x5                    @OBJ palette pointer
    lsl r1, #24
    mov r2, #0x2
    lsl r2, #8
    add r1, r2                      @Copies colors to the first palette slot
    mov r2, #8
    bl dma3_copy

    pop { r0-r2 }
.endm

@ r0 -> x
@ r1 -> y
@ r2 -> shape (0->square, 1->horizontal, 2->vertical)
@ r3 -> size  (0-3)
@ r4 -> tile base
@ r5 -> palette number
.align 2
.thumb_func
.type sprite.create, %function
sprite.create:
    push { r6, r7 }

    push { r0-r5 }
    ldr r2, =sprite_num
    ldr r2, [r2]
    lsl r2, #3              @Gets which position of the array to access

    lsl r0, #8              @X to fixed point
    lsl r1, #8              @Y to fixed point

    ldr r3, =sprites
    add r3, r2              @Get new sprite memory position
    str r0, [r3]
    str r1, [r3, #4]        @Store X and Y to sprites array
    pop { r0-r5 }

    mov r7, #0xFF           @Truncates Y
    and r1, r7
    mov r7, #0b11           @Truncates shape
    and r2, r7
    lsl r2, #14             @Shifts shape to correct bits
    mov r7, #0b1            @Affine sprite with double size box
    lsl r7, #8
    orr r1, r7
    orr r1, r2              @OBJ attrib 0

    mov r7, #0x1
    lsl r7, #8
    add r7, #0xFF
    and r0, r7              @Truncates X
    mov r7, #0b11
    and r3, r7              @Truncates size
    lsl r3, #14             @Shifts size to correct bit
    orr r0, r3              @OBJ attrib 1

    mov r7, #0b11111
    lsl r7, #5
    add r7, #0b11111
    and r4, r7              @Truncates tile base
    mov r7, #0b1111
    and r5, r7              @Truncates palette number
    lsl r5, #12
    orr r4, r5              @OBJ attrib 2

    ldr r2, =sprite_num
    ldr r3, [r2]
    add r3, #1
    str r3, [r2]            @Updates current number of sprites
    sub r3, #1

    lsl r3, #3              @Calculates the memory address of the new sprite
    mov r2, #0x7
    lsl r2, #24
    add r3, r2

    strh r1, [r3]           @Saves the new sprite to OAM
    add r3, #2
    strh r0, [r3]
    add r3, #2
    strh r4, [r3]

    pop { r6, r7 }
    bx lr

@ r0 -> X
@ r1 -> Y
@ r2 -> id
.align 2
.thumb_func
.type sprite.update, %function
sprite.update:
    push { r3, r4 }

    mov r3, #0xFF           @Truncates Y to 8 bits
    and r1, r3

    mov r4, #1
    lsl r4, #8
    add r3, r4              @Truncates X to 9 bits
    and r0, r3

    lsl r2, #3              @ID * 32 is the position in OAM
    mov r4, #0x7
    lsl r4, #24             @0x7000000 is OAM base address
    add r2, r4              @Calculate OAM address of sprite

    ldrh r3, [r2]           @Loads attrib 0 and updates Y
    mov r4, #0xFF
    lsl r4, #8
    and r3, r4              @Clears Y bits
    orr r3, r1              @OR the current Y to attrib 0
    strh r3, [r2]           @Stores attrib 0 back
    add r2, #2

    ldrh r3, [r2]           @Loads attrib 1 and updates X
    mov r4, #0xFE
    lsl r4, #8
    and r3, r4              @Clears X bits
    orr r3, r0              @OR the current X to attrib 1
    strh r3, [r2]           @Stores attrib 1 back

    pop { r3, r4 }
    bx lr

@ r0 -> id
.align 2
.thumb_func
.type sprite.get_x, %function
sprite.get_x:
    push { r1 }

    ldr r1, =sprites
    lsl r0, #3
    ldr r0, [r1, r0]        @Load X from array

    pop { r1 }
    bx lr

@ r0 -> id
@ r1 -> X
.align 2
.thumb_func
.type sprite.set_x, %function
sprite.set_x:
    push { r2 }

    ldr r2, =sprites
    lsl r0, #3
    str r1, [r2, r0]        @Saves X to array

    pop { r2 }
    bx lr

@ r0 -> id
.align 2
.thumb_func
.type sprite.get_y, %function
sprite.get_y:
    push { r1 }

    ldr r1, =sprites
    lsl r0, #3
    add r0, #4
    ldr r0, [r1, r0]        @Gets Y from array

    pop { r1 }
    bx lr

@ r0 -> id
@ r1 -> Y
.align 2
.thumb_func
.type sprite.set_y, %function
sprite.set_y:
    push { r2 }

    ldr r2, =sprites
    lsl r0, #3
    add r0, #4
    str r1, [r2, r0]        @Save Y to array

    pop { r2 }
    bx lr

.section .iwram
.align 2
sprite_num:
    .word 0
.section .iwram
.align 2
sprites:
    .space 128*2
    @Sprites: array of struct
    @                    u32 (.8 fixed point) -> x
    @                    u32 (.8 fixed point) -> y
