## To compile

```
nasm -f elf32 -o main.o main.asm
```

## To link

```
ld -m elf_i386 -o main.exe main.o
```

## To run
```
./main.exe
```

[Source](https://pablocorbalann.medium.com/programming-a-hello-world-in-assembly-from-the-first-line-to-the-end-x86-9c48fb499238)