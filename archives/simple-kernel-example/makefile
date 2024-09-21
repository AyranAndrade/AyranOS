run :
	nasm -f elf32 kernel.asm -o kasm.o
	gcc -m32 -c kernel.c -o kc.o
	ld -m elf_i386 -T linker.ld -o kernel.exe kasm.o kc.o
	qemu-system-i386 -kernel kernel.exe
