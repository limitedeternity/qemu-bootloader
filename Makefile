build:
	nasm -f bin boot.asm -o boot.bin

run: 
	qemu-system-i386 -drive file=boot.bin,index=0,media=disk,format=raw

clean:
	rm -f *.o
	rm -f *.bin
	rm -f *.elf

