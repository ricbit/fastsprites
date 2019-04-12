all : sprites.com

run : sprites.com
	openmsx -machine Panasonic_FS-A1GT -diska disk -script sprites.tcl -ext debugdevice

sprites.com : sprites.asm
	sjasmplus sprites.asm --lst=sprites.lst --sym=sprites.sym
	mkdir -p disk
	cp sprites.com disk/

