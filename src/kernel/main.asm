org 0x7C00
bits 16

;os boots then freezes
main:
    mov ax,0
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov si,os_boot_msg
    call print

    mov sp,0x7C00 ;sp = stack pointer
    hlt ;halt (pauses cpu)

halt:
    jmp halt

print:
    push si 
    push ax 
    push bx 

print_loop:
    lodsb ;loads single byte (character) of string into al register
    or al,al
    jz done_print

    mov ah,0x0E
    mov bh,0
    int 0x10 ;video interupt (prints character)

    jmp print_loop

done_print:
    pop bx 
    pop ax 
    pop si 
    ret

os_boot_msg: db 'OS has booted!', 0x0D, 0x0A, 0 ;0x0D & 0x0A are newline '\n' characters

times 510-($-$$) db 0 ;write zeros until byte #510 is reached
dw 0AA55h ;last 2 bytes equal '0AA55h', the signature the BIOS is looking for