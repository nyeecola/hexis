
@{{BLOCK(o_sprite)

@=======================================================================
@
@	o_sprite, 32x32@4, 
@	Transparent color : FF,00,FF
@	+ palette 16 entries, not compressed
@	+ 16 tiles Metatiled by 4x4 not compressed
@	Total size: 32 + 512 = 544
@
@	Time-stamp: 2019-02-19, 10:58:22
@	Exported by Cearn's GBA Image Transmogrifier, v0.8.15
@	( http://www.coranac.com/projects/#grit )
@
@=======================================================================

	.section .rodata
	.align	2
	.global o_spriteTiles		@ 512 unsigned chars
	.hidden o_spriteTiles
o_spriteTiles:
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x22222222,0x23333331,0x23333331,0x23333331,0x23333331,0x23333331,0x23333331,0x11111111
	.word 0x22222222,0x23333331,0x23333331,0x23333331,0x23333331,0x23333331,0x23333331,0x11111111
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000

	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x22222222,0x23333331,0x23333331,0x23333331,0x23333331,0x23333331,0x23333331,0x11111111
	.word 0x22222222,0x23333331,0x23333331,0x23333331,0x23333331,0x23333331,0x23333331,0x11111111
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000

	.section .rodata
	.align	2
	.global o_spritePal		@ 32 unsigned chars
	.hidden o_spritePal
o_spritePal:
	.hword 0x7C1F,0x0019,0x319F,0x001F,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

@}}BLOCK(o_sprite)