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

@ Copies GRIT generated data to vram
.macro copy_32x32_sprite name tilebase palette
    push { r0-r2 }

    ldr r0, =\name\()Tiles
    mov r1, #0x6
    lsl r1, #8
    add r1, #0x1                    @OBJ tile vram location
    lsl r1, #16
    mov r2, #\tilebase
    lsl r2, #5                      @each tile base -> 32 bytes offset (size of a tile)
    add r1, r2
    mov r2, #1
    lsl r2, #7                      @32x32 sprite is 4x4 tiles -> 16 tiles * 8 word per tile
    bl dma3_copy

    ldr r0, =\name\()Pal
    mov r1, #0x5                    @OBJ palette pointer
    lsl r1, #24
    mov r2, #0x2
    lsl r2, #8
    add r1, r2                      @Copies colors to the first palette slot
    mov r2, #\palette
    lsl r2, #5
    add r1, r2
    mov r2, #8
    bl dma3_copy

    pop { r0-r2 }
.endm

@ Copies GRIT generated data to vram
@ tilebase and palette must be register r3++
.macro copy_32x32_sprite_reg name tilebase palette
    push { r0-r2 }

    ldr r0, =\name\()Tiles
    mov r1, #0x6
    lsl r1, #8
    add r1, #0x1                    @OBJ tile vram location
    lsl r1, #16
    mov r2, \tilebase
    lsl r2, #5                      @each tile base -> 32 bytes offset (size of a tile)
    add r1, r2
    mov r2, #1
    lsl r2, #7                      @32x32 sprite is 4x4 tiles -> 16 tiles * 8 word per tile
    bl dma3_copy

    ldr r0, =\name\()Pal
    mov r1, #0x5                    @OBJ palette pointer
    lsl r1, #24
    mov r2, #0x2
    lsl r2, #8
    add r1, r2                      @Copies colors to the first palette slot
    mov r2, \palette
    lsl r2, #5
    add r1, r2
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

    pop { r0-r5 }

    mov r7, #0xFF           @Truncates Y
    and r1, r7
    mov r7, #0b11           @Truncates shape
    and r2, r7
    lsl r2, #14             @Shifts shape to correct bits
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

.thumb_func
.type update_next_sprites, %function
update_next_sprites:
    push {r0-r5, lr}

    ldr r0, =next_block_types
    ldr r5, =update_next_sprites.loop
    mov r3, #1
    mov r4, #41

update_next_sprites.loop:
    mov r1, r3
    sub r1, #1
    ldrb r1, [r0, r1]

    cmp r1, #0
    bne update_next_sprites.switch1
    copy_32x32_sprite_reg o_sprite r4 r3
    b update_next_sprites.switchend
update_next_sprites.switch1:
    cmp r1, #1
    bne update_next_sprites.switch2
    copy_32x32_sprite_reg i_sprite r4 r3
    b update_next_sprites.switchend
update_next_sprites.switch2:
    cmp r1, #2
    bne update_next_sprites.switch3
    copy_32x32_sprite_reg t_sprite r4 r3
    b update_next_sprites.switchend
update_next_sprites.switch3:
    cmp r1, #3
    bne update_next_sprites.switch4
    copy_32x32_sprite_reg l_sprite r4 r3
    b update_next_sprites.switchend
update_next_sprites.switch4:
    cmp r1, #4
    bne update_next_sprites.switch5
    copy_32x32_sprite_reg j_sprite r4 r3
    b update_next_sprites.switchend
update_next_sprites.switch5:
    cmp r1, #5
    bne update_next_sprites.switch6
    copy_32x32_sprite_reg s_sprite r4 r3
    b update_next_sprites.switchend
update_next_sprites.switch6:
    cmp r1, #6
    bne update_next_sprites.switchend
    copy_32x32_sprite_reg z_sprite r4 r3
update_next_sprites.switchend:

    add r3, #1
    add r4, #40

    cmp r3, #5
    bge update_next_sprites.end
    mov pc, r5

update_next_sprites.end:
    pop {r0-r5, pc}

@ r0 -> X
@ r1 -> Y
@ r2 -> id
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

.ltorg

.section .iwram
.align 2
sprite_num:
    .word 0
