The boot loader needs to do 3 things:

1. Find a kernel and load it into RAM
2. Ensure the CPU is in the correct mode for the kernel to boot
3. Pass any information the kernel may need to boot and can’t find itself

[Source](https://www.qemu.org/2020/07/03/anatomy-of-a-boot/)