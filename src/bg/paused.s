
@{{BLOCK(paused)

@=======================================================================
@
@	paused, 256x256@4, 
@	Transparent color : FF,00,FF
@	+ palette 16 entries, not compressed
@	+ 87 tiles (t|f|p reduced) not compressed
@	+ regular map (flat), not compressed, 32x32 
@	Total size: 32 + 2784 + 2048 = 4864
@
@	Time-stamp: 2019-02-21, 10:33:23
@	Exported by Cearn's GBA Image Transmogrifier, v0.8.15
@	( http://www.coranac.com/projects/#grit )
@
@=======================================================================

	.section .rodata
	.align	2
	.global pausedTiles		@ 2784 unsigned chars
	.hidden pausedTiles
pausedTiles:
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x10000000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x22222000,0x33333332,0x55554433
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00222222,0x02333333,0x03455555
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x20000000,0x33320000,0x44331000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x22222222,0x33333333,0x55555555
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x22000022,0x33200213,0x54320135
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00002222,0x00023333,0x00034555

	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x02222220,0x23333332,0x34555543
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x12000000,0x33100000,0x54330000
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x01333333,0x33344444,0x34555555
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000002,0x00000013
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x22200000,0x33333200,0x55443330
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x22222220,0x33333332,0x55555543
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00002222,0x02333333,0x33344555
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000002

	.word 0x31000000,0x43100000,0x54320000,0x55330000,0x55430000,0x55430000,0x55432000,0x55432000
	.word 0x55555554,0x55555555,0x55555555,0x55555555,0x33345555,0x33333555,0x32023455,0x32003455
	.word 0x03455555,0x03455555,0x03455555,0x03455555,0x03455554,0x03455554,0x23455554,0x23455554
	.word 0x55543100,0x55554310,0x55555432,0x55555533,0x55555543,0x35555543,0x34555543,0x34555543
	.word 0x55555555,0x55555555,0x55555555,0x55555555,0x55553334,0x55553333,0x55553102,0x55553100
	.word 0x55320135,0x55320135,0x55320135,0x55320135,0x55320135,0x55320135,0x55320135,0x55320135
	.word 0x00034555,0x00034555,0x00034555,0x00034555,0x00034555,0x00034555,0x00034555,0x00034555
	.word 0x34555543,0x34555543,0x34555543,0x34555543,0x34555543,0x34555543,0x34555543,0x34555543

	.word 0x55433000,0x55543100,0x55554320,0x55555310,0x55555330,0x55555430,0x55555430,0x55555430
	.word 0x55555555,0x55555555,0x55555555,0x55554455,0x55533334,0x55432233,0x55430023,0x55430023
	.word 0x00000134,0x10002345,0x32003355,0x33023455,0x43023455,0x43023555,0x43223555,0x53223555
	.word 0x55555433,0x55555543,0x55555554,0x55555555,0x34555555,0x33355555,0x02345555,0x00345555
	.word 0x03455555,0x03455555,0x03455555,0x03455555,0x01333333,0x00111113,0x00000000,0x00000000
	.word 0x55555543,0x55555543,0x55555543,0x55555543,0x35555543,0x35555543,0x35555543,0x35555543
	.word 0x34555555,0x45555555,0x55555555,0x55555555,0x55555433,0x55553333,0x55543202,0x55543002
	.word 0x00000023,0x00000033,0x00000134,0x00000335,0x00000345,0x00002345,0x00002355,0x00002355

	.word 0x55532000,0x55532000,0x55532000,0x55532000,0x55532000,0x55532000,0x55532000,0x55532000
	.word 0x32003455,0x32003455,0x32003455,0x31003455,0x33003455,0x43003355,0x43203355,0x53103355
	.word 0x23455554,0x23455555,0x23455555,0x23355555,0x21355555,0x21355555,0x22355555,0x22345555
	.word 0x34555553,0x34555553,0x34555553,0x34555553,0x34555553,0x34555553,0x34555553,0x34555553
	.word 0x55553100,0x55553100,0x55553100,0x55553100,0x55553100,0x55553100,0x55553100,0x55553100
	.word 0x55555430,0x55555430,0x55555430,0x55555430,0x55555330,0x55555310,0x55554320,0x55543100
	.word 0x55430023,0x55430023,0x55430013,0x55430033,0x55430134,0x55431345,0x44333455,0x33334555
	.word 0x53223555,0x53223555,0x53223555,0x53223555,0x53223555,0x53223555,0x53223344,0x53202333

	.word 0x00345555,0x00345555,0x00345555,0x00345555,0x00345555,0x00345555,0x00345555,0x00345555
	.word 0x55543002,0x55543002,0x55543002,0x55543002,0x55543002,0x55543002,0x55543002,0x55543002
	.word 0x00002355,0x00002355,0x00002355,0x00002355,0x00002355,0x00002355,0x00002355,0x00002355
	.word 0x53301355,0x54321355,0x55331355,0x55431355,0x55543355,0x55554355,0x55555555,0x55555555
	.word 0x20345555,0x20335555,0x20234555,0x20034555,0x20013555,0x20023455,0x20001345,0x20000334
	.word 0x34555553,0x34555553,0x34555553,0x34555553,0x34555553,0x44555553,0x55555553,0x55555553
	.word 0x55553100,0x55553100,0x55553100,0x55553100,0x55553333,0x55554444,0x55555555,0x55555555
	.word 0x55533000,0x55332000,0x53320000,0x33200000,0x32000000,0x20000000,0x00000000,0x00000000

	.word 0x23345555,0x33455555,0x35555555,0x55555554,0x55555543,0x55555433,0x55554310,0x55543100
	.word 0x53200000,0x53200002,0x53200023,0x53200033,0x53200334,0x53202345,0x53203355,0x53223455
	.word 0x33345555,0x44455555,0x55555555,0x55555555,0x55555555,0x55555555,0x44445555,0x33345555
	.word 0x00333333,0x03444444,0x03455555,0x03455555,0x03455555,0x03455555,0x03344444,0x00333333
	.word 0x45555555,0x34555555,0x33455555,0x01334555,0x00233455,0x00003455,0x00003455,0x00003455
	.word 0x20000233,0x20000023,0x20000002,0x20000000,0x20000000,0x20000000,0x20000000,0x20000000
	.word 0x55555553,0x55555553,0x45555553,0x34555553,0x34555553,0x34555553,0x34555553,0x34555553
	.word 0x00000000,0x00000000,0x00000000,0x33333300,0x44444330,0x55555430,0x55555430,0x55555430

	.word 0x55533000,0x55432000,0x55430000,0x55430002,0x55430023,0x55430023,0x55430023,0x55430023
	.word 0x53223555,0x53223555,0x53223555,0x53223555,0x53223555,0x53223555,0x53223555,0x53223555
	.word 0x00003455,0x00003455,0x00003455,0x00003455,0x00003455,0x00003455,0x00003455,0x00003455
	.word 0x20000000,0x20000000,0x20000000,0x20000000,0x20000000,0x20000000,0x20000000,0x20000000
	.word 0x55320135,0x55320135,0x55320135,0x55320135,0x54320135,0x54320135,0x54300135,0x53300135
	.word 0x00034555,0x00034555,0x00034555,0x20034555,0x20034555,0x10234555,0x33335555,0x43455555
	.word 0x34555543,0x34555543,0x34555543,0x34555543,0x34555553,0x34555553,0x33555554,0x13555555
	.word 0x55555430,0x55555430,0x55555430,0x55555430,0x55555430,0x55555430,0x55555330,0x55555310

	.word 0x55430023,0x55430023,0x55430023,0x55430023,0x55430023,0x55432033,0x55533334,0x55554445
	.word 0x53223555,0x53223555,0x53223555,0x53223555,0x53223555,0x53223555,0x53223555,0x53223455
	.word 0x00345555,0x00345555,0x00345555,0x00345555,0x00345555,0x22345555,0x33345555,0x55555555
	.word 0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x02222222,0x22333333,0x23455555
	.word 0x35555543,0x35555543,0x35555543,0x35555543,0x35555543,0x35555543,0x35555543,0x55555543
	.word 0x55543002,0x55543002,0x55543002,0x55543002,0x55543202,0x55553312,0x55554333,0x55555555
	.word 0x00002355,0x00002355,0x00002355,0x00002355,0x00002355,0x00002345,0x00002345,0x00000345
	.word 0x55532000,0x55532000,0x55532000,0x55532000,0x33332000,0x33320000,0x00000000,0x00000000

	.word 0x00003455,0x00003455,0x00003455,0x00003455,0x00003333,0x00000333,0x00000000,0x00000000
	.word 0x20000000,0x20000000,0x20000000,0x20000000,0x20000000,0x00000000,0x00000000,0x00000000
	.word 0x34555553,0x34555553,0x34555553,0x34555553,0x33333333,0x03333332,0x00000000,0x00000000
	.word 0x55553100,0x55553100,0x55553100,0x55553100,0x33333100,0x33331000,0x00000000,0x00000000
	.word 0x43100135,0x43000135,0x31000135,0x10000135,0x00000133,0x00000013,0x00000000,0x00000000
	.word 0x55555555,0x55555555,0x55555554,0x55555543,0x45544331,0x33333320,0x22220000,0x00000000
	.word 0x23455555,0x03355555,0x02345555,0x00234555,0x00023344,0x00002133,0x00000002,0x00000000
	.word 0x55554320,0x55553300,0x55533200,0x54332000,0x33320000,0x31000000,0x00000000,0x00000000

	.word 0x55555555,0x55555555,0x55555555,0x45555555,0x33445544,0x23333333,0x00022222,0x00000000
	.word 0x53203355,0x53202345,0x53200134,0x53200013,0x33200001,0x32000000,0x00000000,0x00000000
	.word 0x55555555,0x55555555,0x55555555,0x55555555,0x33333333,0x33333333,0x00000000,0x00000000
	.word 0x23555555,0x23555555,0x23555555,0x23555555,0x23333333,0x02333333,0x00000000,0x00000000
	.word 0x55555543,0x55555543,0x55555543,0x55555543,0x33333333,0x33333330,0x00000000,0x00000000
	.word 0x55555555,0x55555555,0x35555555,0x33445555,0x23333333,0x00221133,0x00000000,0x00000000
	.word 0x00000134,0x00000233,0x00000023,0x00000002,0x00000000,0x00000000,0x00000000,0x00000000

	.section .rodata
	.align	2
	.global pausedMap		@ 2048 unsigned chars
	.hidden pausedMap
pausedMap:
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9001
	.hword 0x9002,0x9003,0x9004,0x9005,0x9006,0x9007,0x9008,0x9009
	.hword 0x900A,0x900B,0x900C,0x9003,0x900D,0x900E,0x900F,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9010
	.hword 0x9011,0x9012,0x9013,0x9014,0x9015,0x9016,0x9017,0x9018
	.hword 0x9019,0x901A,0x901B,0x901C,0x901D,0x901E,0x901F,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9020
	.hword 0x9021,0x9022,0x9023,0x9024,0x9015,0x9016,0x9017,0x9025
	.hword 0x9026,0x9027,0x9028,0x9000,0x9423,0x9029,0x902A,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9020
	.hword 0x902B,0x902C,0x902D,0x902E,0x9015,0x9016,0x9017,0x902F
	.hword 0x9030,0x9031,0x9032,0x9033,0x9423,0x9029,0x902A,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9020
	.hword 0x9034,0x9035,0x9036,0x982E,0x9015,0x9016,0x9017,0x9037
	.hword 0x9038,0x9039,0x9028,0x9000,0x9423,0x9029,0x902A,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9020
	.hword 0x903A,0x903B,0x9023,0x9024,0x903C,0x903D,0x903E,0x903F
	.hword 0x9040,0x9041,0x9042,0x9043,0x9044,0x9045,0x9046,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9047
	.hword 0x9048,0x9049,0x904A,0x904B,0x904C,0x904D,0x904E,0x904F
	.hword 0x9050,0x9051,0x9052,0x9053,0x9054,0x9055,0x9056,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000
	.hword 0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000,0x9000

	.section .rodata
	.align	2
	.global pausedPal		@ 32 unsigned chars
	.hidden pausedPal
pausedPal:
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.hword 0x7C1F,0x0000,0x0000,0x0000,0x4230,0x77DD,0x0000,0x0000
	.hword 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

@}}BLOCK(paused)
