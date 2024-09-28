org 0x7c00

boot:

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    mov ah, 0x02
    mov al, 2
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0
    mov bx, 0x7e00
    int 0x13

    jmp 0x7e00

    times 510-($-$$) db 0x4f
    dw 0xaa55
