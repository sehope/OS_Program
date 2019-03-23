boot.bin: bootloader.asm
		nasm bootloader.asm -f bin -o boot.bin
		sudo dd if=boot.bin bs=512 of=/dev/fd0

qemu: boot.bin
		nasm -f bin bootloader.asm -o myos.bin
		qemu-system-x86_64 myos.bin

clean:
		rm *.bin