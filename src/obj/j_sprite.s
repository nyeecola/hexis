
@{{BLOCK(j_sprite)

@=======================================================================
@
@	j_sprite, 32x32@4, 
@	Transparent color : FF,00,FF
@	+ palette 16 entries, not compressed
@	+ 16 tiles not compressed
@	Total size: 32 + 512 = 544
@
@	Time-stamp: 2019-02-19, 17:55:25
@	Exported by Cearn's GBA Image Transmogrifier, v0.8.15
@	( http://www.coranac.com/projects/#grit )
@
@=======================================================================

	.section .rodata
	.align	2
	.global j_spriteTiles		@ 512 unsigned chars
	.hidden j_spriteTiles
j_spriteTiles:
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x22220000,0x33310000,0x33310000,0x33310000,0x33310000,0x33310000,0x33310000,0x11110000
	.word 0x00002222,0x00002333,0x00002333,0x00002333,0x00002333,0x00002333,0x00002333,0x00001111
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000

	.word 0x22220000,0x33310000,0x33310000,0x33310000,0x33310000,0x33310000,0x33310000,0x11110000
	.word 0x22222222,0x33312333,0x33312333,0x33312333,0x33312333,0x33312333,0x33312333,0x11111111
	.word 0x22222222,0x33312333,0x33312333,0x33312333,0x33312333,0x33312333,0x33312333,0x11111111
	.word 0x00002222,0x00002333,0x00002333,0x00002333,0x00002333,0x00002333,0x00002333,0x00001111
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000

	.section .rodata
	.align	2
	.global j_spritePal		@ 32 unsigned chars
	.hidden j_spritePal
j_spritePal:
	.hword 0x7C1F,0x0339,0x33FF,0x03FF,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

@}}BLOCK(j_sprite)