bits 32                ; NASM directive - 32-bit
section .text

global start
extern kernel_main     ; kernel_main should match the function name in the C file

start:
    cli                ; Block interrupts
    mov esp, stack_space  ; Set stack pointer
    call kernel_main
    hlt                ; Halt the CPU

section .bss
resb 8192              ; 8KB for stack
stack_space:
