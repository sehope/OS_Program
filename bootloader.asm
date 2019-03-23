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





BITS 16								; choose 16 bit mode
ORG 0x7C00							; assemble the instructions from origin 0x7C00

; ---

_BOOT:
	mov ax, 0x2401
	int 0x15
	mov ax, 0x3
	int 0x10
	cli
	lgdt [gdt_pointer]
	mov eax, cr0
	or eax,0x1
	mov cr0, eax
	jmp CODE_SEG:_BOOT2
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

BITS 32
_BOOT2:
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

; --- write to screen via VGA text buffer ---
	mov esi,_DISPLAY
	mov ebx,0xb8000 	;vga text buffer memory mapped to this loc
_LOOP_START:
	lodsb
	or al,al
	jz _HALT
	or eax,0x0500
	mov word [ebx], ax
	add ebx,2
	jmp _LOOP_START
_HALT:
	cli
	hlt
_DISPLAY: db "Hello from the Bootloader! :^)",0

; ---

TIMES 510 - ($-$$) db 0					; make sure length is 512 bytes
DW 0xAA55								; boot signature