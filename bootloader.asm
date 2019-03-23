; steps (from lecture)
; - choose 16 bit mode (real mode) x
; - organize a memory location (0x7C00) where BIOS will load your code x
; - START:
;		- set register to 0
;		- set data segment to 0
;		- set extra segment to 0
; -Jump from real mode to protected mode x
; -Pass the control over to main
;		- main part takes control after step 5, which is the primary place all program operations take place
;		-display
;		-before displaying message, the screen must be cleared. BIOS uses special interruption.
; - add boot signature at end of bootloader x
; -----------------------------------------------------------------------------------------





BITS 16								; choose 16 bit mode
ORG 0x7C00							; assemble the instructions from origin 0x7C00

; ---

mov ax, 0x0003						; 00 in ah for setting video mode & size, 03 in al for telling it to be 80 x 25 chars
int 0x10							; interrupt  10 manages writing chars to screen



; --- Entering Protected Mode ---

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

; ---

TIMES 510 - ($-$$) db 0				; make sure length is 512 bytes
DW 0xAA55							; boot signature