BITS 16

start:
    cli
    cld

    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Load the kernel
    mov bx, 0x8000
    mov dh, 0
    mov dl, 0

load_kernel:
    mov ah, 0x02
    mov al, 1
    mov ch, dh
    mov cl, dl
    mov dh, 0
    int 0x13

    jnc boot_kernel

    ; Handle error
    mov bx, msg_error
    call print_string
    jmp $

boot_kernel:
    ; Jump to the kernel entry point
    jmp 0x0000:0x8000

print_string:
    pusha
    mov ah, 0x0E
.print_char:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .print_char
.done:
    popa
    ret

msg_error db 'Disk error', 0
times 510-($-$$) db 0
dw 0xAA55
