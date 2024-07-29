BITS 32

section .text
global start

start:
    cli
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call kernel_main

.hang:
    jmp .hang
