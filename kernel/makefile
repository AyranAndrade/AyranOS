clean :
	rm *.o *.bin

build :
	nasm -f elf32 kernel.asm -o kernel-assembly.o
	gcc -m32 -c main.c -o main-c.o
	gcc -m32 -c string.c -o string-c.o
	ld -m elf_i386 -T kernel.ld -o kernel.bin *.o

run : build
	qemu-system-i386 -kernel kernel.bin
