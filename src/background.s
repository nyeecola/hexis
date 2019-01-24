.text

@ Copies GRIT generated data to vram
.macro copy_512x512_bg name tile_count tilebase mapbase
    push { r0-r2 }

    ldr r0, =\name\()Tiles          @Tile source
    mov r1, #0x6
    lsl r1, #24
    mov r2, #\tilebase              @VRAM base pointer + TileBase * 0x4000
    lsl r2, #14
    add r1, r2
    mov r2, #\tile_count            @4bpp tile size is 8 words
    bl dma3_copy

    ldr r0, =\name\()Map             @GRIT generated map
    mov r1, #0x6
    lsl r1, #24
    mov r2, #\mapbase               @VRAM + MapBase*0x800
    lsl r2, #11
    add r1, r2
    mov r2, #1                      @512x512 bg uses 4 base maps (4*0x800 bytes/4bytes per word)
    lsl r2, #11
    bl dma3_copy

    ldr r0, =\name\()Pal            @grit palette
    mov r1, #0x5                    @palette memory
    lsl r1, #24
    mov r2, #8                      @each color is 16bit
    bl dma3_copy

    pop { r0-r2 }
.endm
