all : sprites.com

run : 
	echo "make_original equ 1" > sprites.asm
	cat spritesrc.asm >> sprites.asm
	sjasmplus sprites.asm --lst=sprites.lst --sym=sprites.sym
	mkdir -p disk
	cp sprites.com disk/
	openmsx -machine Panasonic_FS-A1GT -diska disk -script sprites.tcl \
    -ext debugdevice | python3 parse.py > original.txt
	echo "make_original equ 0" > sprites.asm
	cat spritesrc.asm >> sprites.asm
	sjasmplus sprites.asm --lst=sprites.lst --sym=sprites.sym
	mkdir -p disk
	cp sprites.com disk/
	openmsx -machine Panasonic_FS-A1GT -diska disk -script sprites.tcl \
    -ext debugdevice | python3 parse.py > refactored.txt
	echo "Difference: "
	diff original.txt refactored.txt


