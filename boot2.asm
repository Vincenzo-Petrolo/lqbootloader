bits 16
org 0x7c00

boot:
	mov ax, 0x2401
	int 0x15
	mov ax, 0x3
	int 0x10
	cli
	lgdt [gdt_pointer]
	mov eax, cr0
	or eax,0x1
	mov cr0, eax
	jmp CODE_SEG:boot2
gdt_start:
	dq 0x0
gdt_code:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
gdt_data:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
gdt_end:
gdt_pointer:
	dw gdt_end - gdt_start
	dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

bits 32

printString:
	mov ebx,0xb8000
printStringIn:
	lodsb
	or al,al
	jz printStringOut
	or eax,0x0100
	mov word [ebx], ax
	add ebx,2
	jmp printStringIn
printStringOut:
    ret

boot2:
	mov esi,hello
    call printString
halt:
	cli
	hlt

hello: db "Welcome to lqbootloader",0

times 510 - ($-$$) db 0
dw 0xaa55
