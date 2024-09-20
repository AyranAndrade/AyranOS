# Steps to Make QEMU Load Your Kernel

### Compile the C Code

Now, compile the `kernel.c` file to generate the object file using `gcc`. Remember to disable the use of standard libraries with `-ffreestanding`, as you won't have access to the normal C library functions in a kernel.

```
gcc -c entry.c -o kernel.o -ffreestanding -nostdlib
```

Explanation of the flags:

* `-ffreestanding`: Indicates that the code is independent of standard libraries.
* `-nostdlib`: Excludes the use of the standard library and the default startup system.

### How to Link

```
ld -T kernel.ld -o kernel.bin kernel.o
```

### How to Run

```
qemu-system-x86_64 -kernel kernel.bin -nographic -machine type=pc-i440fx-3.1
```

### Explanation about linker

* ENTRY(_start) This line defines the entry point of your program, meaning the address where execution will start. The _start function is the initial point of your kernel, where control will be transferred once the kernel is loaded into memory. The name _start corresponds to the function you've defined in assembly or C to begin kernel execution.

* SECTIONS The SECTIONS directive defines the different parts (sections) of your program and where they should be placed in memory. This is crucial for kernels and operating systems, as you need to ensure that code, data, and other information are loaded at the correct memory addresses.

* . = 0x100000; This line specifies that from this point, the memory address will be set to 0x100000 (1 MB). This is the address where the kernel will be loaded into memory. The dot (.) represents the linker's location counter, indicating the current address where the data is being placed.

* 0x100000 is a commonly used address to load kernels (as explained previously).

* *.text : { (.text) } .text is the section where the executable code of your program will be placed (the logic of the kernel itself, such as functions, etc.). The directive *(.text) means that all symbols belonging to the .text section of the object files should be included here. In other words, this line is telling the linker: "Place all the code from the .text section of the object files here, starting at the current address (which in this case is 0x100000)."

* *.rodata : { (.rodata) } .rodata means read-only data, i.e., data that can only be read, such as constants and strings that cannot be modified. The directive *(.rodata) places all the data that belongs to the .rodata section (read-only data) here.

* *.data : { (.data) } .data is the section where mutable data is placed. These are variables that can be modified at runtime. The directive *(.data) places all symbols from the .data section (read-write data) in this memory area.

* **.bss : { (.bss) (COMMON) } .bss (Block Started by Symbol) is a section that contains uninitialized variables. What happens is that space will be reserved for these variables, but they will not take up space in the binary file because their initial value is zero. The directive *(.bss) is telling the linker: "Place all variables that belong to the .bss section here." *(COMMON): This instructs the linker to also include common variables (usually uninitialized global variables in C) that are defined without an initial value. Common variables are treated similarly to .bss variables.