org 0x7C00
bits 16

jmp short main 
nop 

bdb_oem: db 'MSWIN4.1' 
bdb_bytes_per_sector: dw 512 
bdb_sectors_per_cluster: db 1 
bdb_reserved_sectors: dw 1 
bdb_fat_count: db 2
bdb_dir_entries_count: dw 0E0h
bdb_total_sectors: dw 2880
bdb_media_descriptor_type: db 0F0h
bdb_sectors_per_fat: dw 9
bdb_sectors_per_track: dw 18
bdb_heads: dw 2
bdb_hidden_sectors: dd 0
bdb_large_sector_count: dd 0

ebr_drive_number: db 0
                  db 0
ebr_signature db 29h
ebr_volume_id: db 12h,34h,56h,78h
ebr_volumne_label: db 'ST OS      ' ;11 bytes (characters)
ebr_system_id: db 'FAT12   ' ;8 bytes (characters)

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