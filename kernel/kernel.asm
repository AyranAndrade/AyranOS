bits 32
section .text
	;multiboot spec
	align 4
	dd 0x1BADB002 ;magic number
	dd 0x00	;flags
	dd - (0x1BADB002 + 0x00) ;checksum

global start
extern main

start:
	cli	;block interrupts
	call main
	hlt	;halt the CPU

section .note.GNU-stack noalloc noexec nowrite progbits