[ORG 0x7c00] ; In which address the bootloader starts
[BITS 16] ; Bootloader is 16 bit

start:
 mov ax, 0012h ; 640x480 16-color graphics video mode
 int 0x10 ; Calls BIOS video interrupt
 mov si, message ; Stores message into the String Index Register si
 mov bl, 4 ; Color red
 call print ; Calls print function
 jmp $ ; Jumps to current address

print:
 mov bh, 0 ; Page 0

.loop:
 lodsb ; Loads the first byte of the string into al
 cmp al, 0 ; Compares al with 0
 je .done ; If zero, then jumps to .done
 call print_char ; Else, calls print_char
 jmp .loop ; Jumps to its self for loop

.done:
 ret ; Returns control to the calling procedure

print_char:
 mov ah, 0x0E ; Video Teletype Output, to display character on the screen
 int 0x10 ; Calls BIOS video interrupt
 ret ; Returns control to the calling procedure

message db "KATSARXS SYSTEM LXADING...", 0 ; Defines a byte in the memory to be used as string. 0 = null terminator, which shows the end of the string

times 510 - ($ - $$) db 0 ; Fills the remaining bytes with zeroes
dw 0xAA55 ; Boot signature for BIOS to recognize us