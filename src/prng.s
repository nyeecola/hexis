	.text
	.thumb_func
	.type	xorshift32, %function
xorshift32:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, #16
	mov	r7, sp
	str	r0, [r7, #4]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	lsl	r3, #13
	ldr	r2, [r7, #12]
	eor	r3, r2
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	lsr	r3, #17
	ldr	r2, [r7, #12]
	eor	r3, r2
	str	r3, [r7, #12]
	ldr	r3, [r7, #12]
	lsl	r3, #5
	ldr	r2, [r7, #12]
	eor	r3, r2
	str	r3, [r7, #12]
	ldr	r3, [r7, #4]
	ldr	r2, [r7, #12]
	str	r2, [r3]
	ldr	r3, [r7, #12]
	mov	r0, r3
	mov	sp, r7
	add	sp, #16
	@ sp needed
	pop	{r7}
	pop	{r1}
	bx	r1
	.size	xorshift32, .-xorshift32
	.ident	"GCC: (devkitARM release 50) 8.2.0"
