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

.macro macroPrintString str
    lea \str, %si
    call printString
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
    macroPrintString welcome_message    
    jmp .
/*Magic numbers*/
 . = _start + 510
.byte 0x55
.byte 0xAA
