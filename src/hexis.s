.text
.align 2
.thumb_func
.type fill_block, %function
fill_block:
    @ this functions assumes palette 0 is the one used for the given map base
    @ parameters: x y mapbase color
    @ color must be one of the following:
    @ - 3 for red
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
    
