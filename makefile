clean :
	find . -type f -name '*.bin' -delete
	find . -type f -name '*.o' -delete
	find . -type f -name '*.exe' -delete

build : *.c
	gcc -c *.c -o kernel.o -ffreestanding -nostdlib
	ld -T kernel.ld -o kernel.bin kernel.o

run : build
	qemu-system-x86_64 -kernel kernel.bin -machine type=pc-i440fx-3.1
