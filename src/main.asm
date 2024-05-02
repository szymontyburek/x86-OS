org 0x7C00
bits 16

;os boots then freezes
main:
    hlt ;halt (pauses cpu)

halt:
    jmp halt

times 510-($-$$) db 0 ;write zeros until byte #510 is reached
dw 0AA55h ;last 2 bytes equal '0AA55h', the signature the BIOS is looking for