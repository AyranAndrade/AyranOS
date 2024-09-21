clean :
	rm *.o *.exe

build :
	nasm -f elf32 kernel.asm -o kasm.o
	gcc -m32 -c main.c -o kc.o
	ld -m elf_i386 -T kernel.ld -o kernel.exe kasm.o kc.o

run : build
	qemu-system-i386 -kernel kernel.exe
