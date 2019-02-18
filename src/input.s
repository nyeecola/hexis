.text
.align 2
.thumb_func
.type input_handling, %function
@ Returns in r3 the game timer max
input_handling:
    push {r0-r2, r4, r5, lr}

    mov r0, #0x4                    @r0 = KEYINPUT
    lsl r0, #24
    mov r1, #0x13
    lsl r1, #4
    add r0, r1
    ldr r0, [r0]                    @Load user input
    mvn r0, r0                      @Makes pressed button = 1 (default is = 0)

input.start:
    cmp input_timer, #0             @If the input delay timer is zero
    beq input.right                 @Accepts a new input
    sub input_timer, #1             @Else, count one more frame and ignore input
    b input.end

input.right:
    mov r1, #1
    lsl r1, #4
    and r1, r0                      @If "right" bit is set
    cmp r1, #0
    beq input.left
    @ handle right pressed here

    push {r0-r3}
    mov r0, #1
    mov r1, #0
    mov r2, #0b100
    mov r3, #1
    bl did_hit_something
    cmp r0, #1
    pop {r0-r3}
    beq input.left

    ldr r2, =active_block_position
    mov r4, #1
    ldrsb r1, [r2,r4]               @ Loads X
    add r1, #1                      @ If input is not ignored anywhere
    strb r1, [r2,#1]                @ Moves block right and stores it back to ram
    mov input_timer, #INPUT_DELAY   @Valid input increases the input delay timer

input.left:
    mov r1, #1
    lsl r1, #5
    and r1, r0                      @If "left" bit is set
    cmp r1, #0
    beq input.up
    @ handle left pressed here

    push {r0-r3}
    mov r0, #1
    neg r0, r0
    mov r1, #0
    mov r2, #0b010
    mov r3, #1
    bl did_hit_something
    cmp r0, #1
    pop {r0-r3}
    beq input.up

    ldr r2, =active_block_position
    mov r4, #1
    ldrsb r1, [r2,r4]               @ Loads X
    sub r1, #1                      @if input is not ignored anywhere
    strb r1, [r2,#1]                @moves block left and stores it back to ram
    mov input_timer, #INPUT_DELAY   @Valid input increases the input delay timer

input.up:
    mov r1, #1
    lsl r1, #6
    and r1, r0                      @If "up" bit is set
    cmp r1, #0
    beq input.down
    @ handle up pressed here

input.down:
    mov r1, #1
    lsl r1, #7
    and r1, r0                      @If "down" bit is set
    cmp r1, #0
    beq input.a
    @ handle down pressed here

    mov r3, #SOFTDROP_DELAY         @Cuts down game timer, making blocks fall faster
    @ purposefully not adding input delay

input.a:
    mov r1, #1
    and r1, r0                      @If "A" bit is set
    cmp r1, #0
    beq input.b
    @ handle A pressed here

    ldr r2, =active_block_rotation
    ldrb r4, [r2]
    mov r8, r4                              @ store old rotation temporarily
    add r4, #1
    cmp r4, #4
    bne skip_a_rotation_index_reset
    mov r4, #0
skip_a_rotation_index_reset:
    strb r4, [r2]

    push {r0-r3}

    push {r2}

    mov r0, #0
    mov r1, #0
    mov r2, #0b111
    mov r3, #0
    bl did_hit_something

    pop {r2}

    cmp r0, #0
    beq skip_a_rotation_reset
    mov r0, r8
    strb r0, [r2]
skip_a_rotation_reset:

    pop {r0-r3}

    @TODO: create a separate timer for rotation, probably not enought registers (use RAM)
    mov input_timer, #ROTATION_DELAY   @Valid input increases the input delay timer

input.b:
    mov r1, #10
    and r1, r0                      @If "B" bit is set
    cmp r1, #0
    beq input.end
    @ handle B pressed here

    ldr r2, =active_block_rotation
    ldrb r4, [r2]
    mov r8, r4                              @ store old rotation temporarily
    cmp r4, #0
    bne skip_b_rotation_index_reset
    mov r4, #4
skip_b_rotation_index_reset:
    sub r4, #1
    strb r4, [r2]

    push {r0-r3}

    push {r2}

    mov r0, #0
    mov r1, #0
    mov r2, #0b111
    mov r3, #0
    bl did_hit_something

    pop {r2}

    cmp r0, #0
    beq skip_b_rotation_reset
    mov r0, r8
    strb r0, [r2]
skip_b_rotation_reset:

    pop {r0-r3}

    @TODO: create a separate timer for rotation, probably not enought registers (use RAM)
    mov input_timer, #ROTATION_DELAY   @Valid input increases the input delay timer

input.end:
    pop {r0-r2, r4, r5, pc}

