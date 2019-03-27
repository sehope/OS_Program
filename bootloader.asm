; ------------------------------------------------------------------------------------------------------------------
; steps (from lecture)
; - choose 16 bit mode (real mode) x
; - organize a memory location (0x7C00) where BIOS will load your code x
; - START:
;		- set register to 0
;		- set data segment to 0
;		- set extra segment to 0
; -Jump from real mode to protected mode x DONT NEED TO DO
; -Pass the control over to main
;		- main part takes control after step 5, which is the primary place all program operations take place
;		-display
;		-before displaying message, the screen must be cleared. BIOS uses special interruption.
; - add boot signature at end of bootloader x
; ------------------------------------------------------------------------------------------------------------------





BITS 16								; choose 16 bit mode
ORG 0x7C00							; assemble the instructions from origin 0x7C00

; ---




; --- entering video mode ---

mov ax, 0x0003						; 00 in ah for setting video mode & size, 03 in al for telling it to be 80 x 25 chars
int 0x10							; interrupt  10 manages writing chars to screen



;jmp _start							; kernel entry point

; ---


; ---



; ---- OS PART ----

start: 
	mov si, text
	call print_string
	jmp $
	text db 'This is our first Operating System!', 0xa, 0xd, 0
	text_user db 'S', 0
	text_pass db 'M', 0

print_string:
	mov ah, 0Eh
	mov bl, 0x3C

.repeat:
	lodsb
	cmp al, 0
	je .done
	int 10h
	jmp .repeat

.done:

	mov ah, 00h
	int 16h
	cmp al, 13
	jne .done

call cls
jmp $

cls: 
	pusha 
	mov ah, 0x00
	mov al, 0x03
	int 0x10
	popa

mov si, text_2
call print_string_2
jmp $
text_2 db 'user name: ', 0
	
print_string_2:
	mov ah, 0Eh

.repeat_2:
	lodsb
	cmp al, 0
	je .done_2
	int 10h
	jmp .repeat_2

.done_2: 
	mov ah, 00h
	int 16h
	cmp al, 83
	jne .done_2

mov si, text_crnl
call print_newline
jmp$
text_crnl db ' ', 0xa, 0xd, 0

print_newline:
	mov ah, 0Eh

.repeat_newline:
	lodsb
	cmp al, 0
	je .done_3
	int 10h
	jmp .repeat_newline

.done_3:
mov si, text_3
call print_string_3
jmp $
text_3 db 'password: ', 0
	
print_string_3:
	mov ah, 0Eh

.repeat_3:
	lodsb
	cmp al, 0
	je .done_4
	int 10h
	jmp .repeat_3

.done_4:
	mov ah, 00h
	int 16h
	cmp al, 77
	jne .done_4

call cls_2
jmp $

cls_2: 
	pusha 
	mov ah, 0x00
	mov al, 0x03
	int 0x10
	popa

mov si, text_5
call print_string_5
jmp $
text_5 db 'Primes:  ', 0xa, 0xd,  0
	
print_string_5:
	mov ah, 0Eh

.repeat_5:
	lodsb
	cmp al, 0
	je .done_5
	int 10h
	jmp .repeat_5
.done_5:
	ret



TIMES 510 - ($-$$) db 0				; make sure length is 512 bytes
DW 0xAA55							; boot signature

; ---- OS PART ----

