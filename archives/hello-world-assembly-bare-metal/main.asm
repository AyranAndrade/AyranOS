section .data
    msg db "Hello World!", 0  ; Mensagem com um terminador nulo

section .bss

section .text
    global _start

_start:
    ; Inicializando o modo de texto VGA (não necessário em muitas máquinas, já está configurado)

    ; A posição da memória de vídeo em modo texto VGA é 0xB8000
    mov esi, msg              ; Apontar para a mensagem
    mov ebx, 0xB8000          ; Endereço da memória de vídeo
    mov ecx, 12               ; Tamanho da string "Hello World!"

print_loop:
    lodsb                     ; Carrega o próximo byte da string em AL
    test al, al                ; Verifica se atingiu o terminador nulo
    jz halt                   ; Se for nulo, fim da mensagem

    ; Escreve o caractere e o atributo na memória de vídeo
    mov [ebx], al             ; Caractere
    mov byte [ebx+1], 0x07    ; Atributo: branco no fundo preto
    add ebx, 2                ; Avança para a próxima célula de memória
    loop print_loop           ; Repete até que a mensagem tenha sido escrita

halt:
    hlt                       ; Para a execução
