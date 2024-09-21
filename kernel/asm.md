# qemu-system-x86_64: Cannot load x86-64 image, give a 32bit one.

Esse erro ocorre porque, apesar de você estar gerando um executável de 64 bits, o QEMU está esperando um kernel que siga o padrão de 32 bits para a inicialização. Isso pode ser resultado de duas coisas principais:

* Multiboot: A especificação Multiboot (como no seu código assembly) geralmente espera um kernel de 32 bits para começar a carregar. Mesmo que o seu kernel seja de 64 bits, o processo de inicialização via Multiboot requer que o estágio inicial (a "bootstrap") seja feito em 32 bits. Somente depois disso o kernel pode mudar para o modo de 64 bits (long mode).

* Modo de Inicialização do QEMU: O comando qemu-system-x86_64 tenta carregar uma imagem que deve começar em 32 bits, exceto se você implementar manualmente a mudança para 64 bits no kernel.

## Soluções
Você tem duas opções:

1. Iniciar o Kernel em Modo de 32 Bits e Depois Alternar para 64 Bits
O código de inicialização (Assembly) pode começar em modo de 32 bits, e, após realizar a configuração necessária, fazer a transição para 64 bits (long mode). Este é o método comum, e aqui está um exemplo de fluxo:

* Kernel Inicia em 32 bits (usando Multiboot).
* Código Assembly Inicializa Componentes Básicos.
* Assembly Transfere Controle para o Kernel de 64 bits.
* Para fazer isso, você precisaria ajustar o código assembly para configurar os registradores e a Tabela de Descritores Globais (GDT) de maneira adequada e, em * seguida, realizar a transição para o modo de 64 bits.

2. Usar GRUB para Carregar o Kernel
Outra solução mais simples seria usar o GRUB como bootloader, já que ele é capaz de carregar kernels Multiboot e fazer a transição para o modo de 64 bits automaticamente.

## Por que usar assembly?

É possível configurar o ponto de entrada diretamente em C, mas há alguns detalhes importantes a considerar. Vamos explorar por que o código assembly é comumente usado e como você pode simplificar o processo se preferir evitar o assembly.

### Razões para Usar Código Assembly

* Inicialização do Sistema: O código assembly pode realizar inicializações específicas do hardware e configurar o ambiente antes de transferir o controle para o código C. Isso inclui configurações de memória, gerenciamento de interrupções e outras tarefas críticas.

* Compatibilidade com Bootloaders: Usar assembly para configurar o ambiente inicial e garantir que o carregador de inicialização (como GRUB) possa transferir o controle corretamente ao kernel C.

* Ponto de Entrada: O código assembly pode garantir que o ponto de entrada (start) seja configurado corretamente e pode fazer configurações que o código C não pode.

## Explique o assembly

O código assembly fornecido é essencial para a criação de um kernel simples que pode ser carregado e executado usando o GRUB. Vou explicar cada parte do código e sua importância:

bits 32: Esta diretiva diz ao assembler que o código deve ser tratado como código de 32 bits. Isso significa que todas as instruções e endereços serão tratados no contexto de uma arquitetura de 32 bits (x86).

section .text: Define a seção de código executável do arquivo binário. O código do kernel vai nesta seção.

Multiboot Specification: O GRUB, um carregador de inicialização, usa a Multiboot Specification para carregar kernels. Essas linhas são usadas para garantir que o GRUB reconheça e carregue o kernel corretamente.

align 4: Alinha o início da próxima seção de dados a um múltiplo de 4 bytes. Isso é necessário para garantir que o magic e outras informações estejam alinhadas corretamente.

dd 0x1BADB002: Este é o "magic number" exigido pela especificação Multiboot. Ele informa ao GRUB que o arquivo é um kernel compatível com Multiboot.

dd 0x00: Flags para a especificação Multiboot. Aqui, é um valor zero, significando que não há opções adicionais especificadas.

dd - (0x1BADB002 + 0x00): Esta linha calcula o checksum. A soma de magic, flags e checksum deve ser zero. O checksum é ajustado automaticamente para garantir que a soma total seja zero.

global start: Marca o rótulo start como global, o que permite que o linker saiba que este é o ponto de entrada do kernel.

extern kmain: Declara que a função kmain é definida em outro lugar (no código C). O assembler não conhece kmain neste ponto, então ele é apenas referenciado aqui.

start:: Este é o ponto de entrada do kernel, o endereço para onde a execução começa.

cli: Bloqueia interrupções. Isso é feito para garantir que o código crítico não seja interrompido por interrupções de hardware.

call kmain: Faz uma chamada para a função kmain, que é definida no arquivo C (kernel.c). Esta é a função principal do kernel, onde você escreve o código do kernel.

hlt: Interrompe a CPU. Após a execução de kmain, o kernel entra em um loop de parada, o que efetivamente "pausa" o sistema, já que não há um sistema operacional real para continuar a execução.