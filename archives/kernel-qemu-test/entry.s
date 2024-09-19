.global _start
.section .text

_start:
    mov $0x1, %rax    # Chama o syscall write
    mov $0x1, %rdi    # File descriptor (stdout)
    mov $msg, %rsi    # Mensagem a imprimir
    mov $len, %rdx    # Comprimento da mensagem
    syscall

    mov $60, %rax     # Chama o syscall exit
    xor %rdi, %rdi    # Código de retorno 0
    syscall

.section .rodata
msg:
    .ascii "Hello, Kernel World!\n"
len = . - msg