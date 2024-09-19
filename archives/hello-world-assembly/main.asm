; https://pablocorbalann.medium.com/programming-a-hello-world-in-assembly-from-the-first-line-to-the-end-x86-9c48fb499238
section .text

global _start
_start:
mov edx, len ; move the length of the message to EDX
mov ecx, msg ; move the message to ECX
mov ebx, 1 ; set the descriptor
mov eax, 4 ; call the kernel to print chars
int 0x80 ; int stands for interruptions. It stops the assembly code and calls the kernel
mov eax, 1
int 0x80

section .data
msg db "Hello World!", 0xa ; 0xa = new line
len equ $ - msg
; equ é uma diretiva que significa "equivalente a", usada para definir constantes.
; $ é um símbolo que representa o endereço atual no momento em que essa linha está sendo processada.
; msg é o rótulo que marca o início da string "Hello world!".
; Então, a expressão $ - msg calcula a diferença entre o endereço atual (que é o endereço logo após o término da string msg) e o endereço onde msg começa.

; Isso resulta no comprimento da string "Hello world!\n"


; nasm -f elf32 -o main.o main.asm
; ld -m elf_i386 -o main.exe main.o ; call the linker