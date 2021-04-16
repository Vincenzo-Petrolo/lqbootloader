.code16
.text
.globl _start
/*Nothing must be declared before _start*/
/*source -> destination, AT&T syntax */
_start:
    mov $0x7c0, %ax
    mov %ax, %ds
    jmp _boot
welcome_message: .asciz "Welcome to lqbootloader - Low Quality Bootloader"
checking_PCI:    .asciz "Checking for PCI..."
error_PCI:       .asciz "ERROR! No PCI"
loading_kernel:  .asciz "Loading kernel..."

.macro macroPrintString str
    lea \str, %si
    call printString
.endm

.macro macroPrintStringNewline str
    lea \str, %si
    call printString
    mov $0x0e, %ah
    mov $0x0d, %al
    int $0x10
    mov $0x0a, %al
    int $0x10
.endm

.macro macroCheckPCI
    macroPrintStringNewline checking_PCI
    mov $0xb101, %ax
    int $0x1a
    orb %ah, %ah
    jz okPCI
errorPCI:
    macroPrintStringNewline errorPCI
okPCI:
    ret
.endm

printString:
printStringIn:
    lodsb
    orb %al, %al
    jz printStringOut
    mov $0x0e, %ah
    int $0x10
    jmp printStringIn
printStringOut:
    ret

_boot:
    macroPrintStringNewline welcome_message    
    /*Check for PCI*/
    macroCheckPCI
    jmp .
/*Magic numbers*/
 . = _start + 510
.byte 0x55
.byte 0xAA
