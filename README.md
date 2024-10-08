# AyranOS
A simple operating system kernel for learning purpose
The name could be iOS (Inefficient Operating System).

## V1
In this version, the OS doesn't have either kernel
interruptions, virtual memory or file system.

## Makefile

### To clean

```
make clean
```

### To build

```
make build
```

### To run

```
make run
```

## QEMU

### How to compile

```
gcc -c entry.c -o kernel.o -ffreestanding -nostdlib
```

### How to link

```
ld -T kernel.ld -o kernel.bin kernel.o
```

### How to run

```
qemu-system-x86_64 -kernel kernel.bin -nographic -machine type=pc-i440fx-3.1
```

In **nographic** mode, QEMU has a special key combination to access the QEMU monitor, where you can issue commands directly. To exit:

Press **Ctrl+A** (hold **Ctrl** and press **A**).  
Then, release **Ctrl** and press **X**.

### To disassemble the executable

```
objdump -d kernel.bin
```

## Read

[Explanation about linker](archives/kernel-qemu-c-language/README.md)

[Explanation about ELF files](archives/kernel-qemu-test/README.md)

[Explanation about how to compile assembly](archives/hello-world-assembly/README.md)

[Explanation about the assembly used in the kernel](kernel/asm.md)

[Tutorial about writing a kernel](https://isu-rathnayaka.medium.com/develop-your-own-x86-operating-system-os-2-9b0d41e60499)