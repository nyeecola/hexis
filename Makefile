all: gfx
	mkdir -p bin
	/opt/devkitpro/devkitARM/bin/arm-none-eabi-gcc -mthumb-interwork -specs=gba.specs src/main.s -o bin/main.o -g
	/opt/devkitpro/devkitARM/bin/arm-none-eabi-objcopy -v -O binary bin/main.o main.gba
	/opt/devkitpro/tools/bin/gbafix main.gba

gfx: force
	mkdir -p bin
	grit gfx/bg0.png -o bin/bg0
	grit gfx/obj0.png -o bin/obj0
	rm bin/*.h

clean:
	rm -rf bin main.gba main.sav

force:
