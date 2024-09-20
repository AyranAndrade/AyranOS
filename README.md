# AyranOS
A simple operating system kernel for learning purpose
The name could be iOS (Inefficient Operating System).

## V1
In this version, the OS doesn't have either kernel
interruptions, virtual memory or file system.

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

## Read

[Explanation about linker](archives/kernel-qemu-c-language/README.md)

[Explanation about ELF files](archives/kernel-qemu-test/README.md)
