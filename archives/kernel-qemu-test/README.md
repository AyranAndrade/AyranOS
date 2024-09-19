# Steps to Make QEMU Load Your Kernel

### File Format: ELF (Executable and Linkable Format)

QEMU expects the kernel to be an ELF file when using the -kernel option. ELF is the standard executable format for Unix-like systems, and it's also used for kernels. You’ll need to compile your assembly or C code to generate an ELF binary.

### Kernel Structure

At the very least, your kernel needs an entry point so the CPU knows where to start executing. This is usually defined in assembly or C and is specified when linking.

### Linker Script

To load the kernel at the correct memory address, you'll need a linker script. This defines where the kernel code will be loaded in memory.

Here’s a basic example of a linker script (kernel.ld) for a 64-bit kernel:

```
ENTRY(_start)

SECTIONS
{
  . = 0x100000;

  .text : {
    *(.text)
  }

  .rodata : {
    *(.rodata)
  }

  .data : {
    *(.data)
  }

  .bss : {
    *(.bss)
    *(COMMON)
  }
}
```

This script tells the linker to place the kernel code at memory address 0x100000. The entry point for the kernel will be _start.

### Assembly Code Example (entry.S)

Now let’s write the assembly code for the kernel’s entry point. This simple example prints a message using a system call and then exits:

```
.global _start
.section .text

_start:
    mov $0x1, %rax    # Call the write syscall
    mov $0x1, %rdi    # File descriptor (stdout)
    mov $msg, %rsi    # Message to print
    mov $len, %rdx    # Message length
    syscall

    mov $60, %rax     # Call the exit syscall
    xor %rdi, %rdi    # Return code 0
    syscall

.section .rodata
msg:
    .ascii "Hello, Kernel World!\n"
len = . - msg
```

This code:

Writes "Hello, Kernel World!" to the terminal using the write syscall.
Exits with a return code of 0 using the exit syscall.

### Compiling the Kernel

To make the assembly code into an ELF kernel, you need to assemble and link it correctly. Here are the commands:

```
as --64 -o main.o entry.S
ld -o main.exe -T kernel.ld main.o
```

as --64: Assembles the code for 64-bit architecture.
ld: Links the object file using the kernel.ld linker script to create the main.exe ELF file.

### Running the Kernel with QEMU

Now that you have your ELF kernel (main.exe), you can run it using QEMU:

```
qemu-system-x86_64 -kernel main.exe -nographic -machine type=pc-i440fx-3.1
```

**Observation:**

There is a problem with original command. The error was
```
Error loading uncompressed kernel without PVH ELF Note
```

Based on this [source](https://stackoverflow.com/a/72248756).

The -nographic option runs QEMU without a graphical window, using your terminal for input/output.

### Verify content from ELF file

```
readelf -a main.exe
```