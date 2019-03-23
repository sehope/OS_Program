cli									; disable interrupts
lgdt [gdt_pointer_to_beginning]		; load GDT reg w address
mov eax, cr0
or al, 1							; set PE bit in CR0
mov cr0, eax

jmp CODE_SEG:boot

gdt_beginning:
	dq 0x0
gdt_code:
	dw 0xFFF
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

gdt_pointer_to_beginning:
	dw gdt_end - gdt_beginning
	dd gdt_beginning

CODE_SEG equ gdt_code - gdt_beginning
DATA_SEG equ gdt_data - gdt_beginning

BITS 32								; choose 32 bit mode

boot:								; load segment registers
	mov ax, DATA_SEG

	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov esi, greeting2
	mov ebx, 0xb8000

print_greeting2:
	lodsb
	or al, al
	jz halt
	or eax, 0x0500
	mov word [ebx], ax
	add ebx, 2
	jmp print_greeting2

halt:
	cli
	hlt

greeting2:
	db "Hello from Protected Mode ! :^)"