# OS_Program

**Bootloader Instructions:**

- compile with: nasm bootloader.asm -f bin -o boot.bin
	- creates boot.bin
- copy bootsector to floppy disk with: sudo dd if=boot.bin bs=512 of=/dev/fd0
- run with qemu: 
	- nasm -f bin bootloader.asm -o myos.bin
	- qemu-system-x86_64 myos.bin