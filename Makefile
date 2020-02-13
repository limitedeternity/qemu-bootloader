build:
	nasm -f bin bootsect.asm -o bootsect.bin
	nasm -f bin preboot.asm -o preboot.bin
	cat bootsect.bin preboot.bin > bootloader.bin

pull_core:
	curl -SL http://tinycorelinux.net/11.x/x86/release/Core-current.iso -o Core.iso

run:
	qemu-system-i386 -k en-us -rtc base=localtime -soundhw sb16,adlib,pcspk -device cirrus-vga -drive file=bootloader.bin,index=0,media=disk,format=raw -drive file=Core.iso,index=1,media=cdrom,format=raw

clean:
	rm -f *.o
	rm -f *.bin
	rm -f *.elf

