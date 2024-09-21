nasm -f elf32 kernel.asm -o kernel-assembly.o

for source in *.c; do
    gcc -m32 -c "$source" -o "${source%.c}.o"
done

ld -m elf_i386 -T kernel.ld -o kernel.bin *.o

qemu-system-i386 -kernel kernel.bin

rm *.o *.bin
