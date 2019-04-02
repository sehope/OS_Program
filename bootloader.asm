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



; ---- OS PART ----

start: 

; ---------------------------  Display the greeting -------------------------------

	mov si, greeting
	call print_greeting
	jmp $
	greeting db 'This is our first Operating System!', 0xa, 0xd, 0
	text_user db 'S', 0 ;user name
	text_pass db 'M', 0 ;password

print_greeting:
	mov ah, 06h
	mov bh, 0Bh
	int 10h
	mov ah, 0Eh

.repeat_greeting:
	lodsb
	cmp al, 0
	je .done_greeting
	int 10h
	jmp .repeat_greeting
; ---------------------------------------------------------------------------------



; ------------------------ Check if user pressed enter ----------------------------
.done_greeting:

	mov ah, 00h
	int 16h
	cmp al, 13
	jne .done_greeting
; ---------------------------------------------------------------------------------




; ----------------------------- Clear Screen---------------------------------------
call cls
jmp $

cls: 
	pusha 
	mov ah, 0x00
	mov al, 0x03
	int 0x10
	popa
; ---------------------------------------------------------------------------------





; -------------------------- Display user name prompt------------------------------
mov si, user_name
call print_user_name
jmp $
user_name db 'user name: ', 0
	
print_user_name:
	mov ah, 06h
	mov bh, 9Dh
	int 10h
	mov ah, 0Eh

.repeat_user_name:
	lodsb
	cmp al, 0
	je .done_user_name
	int 10h
	jmp .repeat_user_name
; ---------------------------------------------------------------------------------




; ------------------------ Check if user name matches 'S' -------------------------
.done_user_name: 
	mov ah, 00h
	int 16h
	cmp al, 83
	jne .done_user_name
; ---------------------------------------------------------------------------------




;-------------------- Display a new line and carriage return ----------------------
mov si, text_crnl
call print_newline
jmp$
text_crnl db ' ', 0xa, 0xd, 0

print_newline:
	mov ah, 0Eh

.repeat_newline:
	lodsb
	cmp al, 0
	je .done_newline
	int 10h
	jmp .repeat_newline
; ---------------------------------------------------------------------------------




; ------------------------ Display Password prompt --------------------------------
.done_newline:
mov si, password
call print_password
jmp $
password db 'password: ', 0
	
print_password:
	mov ah, 0Eh

.repeat_password:
	lodsb
	cmp al, 0
	je .done_password
	int 10h
	jmp .repeat_password
; ---------------------------------------------------------------------------------




;------------------------- Check if user typed 'M' --------------------------------

.done_password:
	mov ah, 00h
	int 16h
	cmp al, 77
	jne .done_password
; ---------------------------------------------------------------------------------




; ------------------------- Clear Screen Again ------------------------------------
call cls_2
jmp $

cls_2: 
	pusha 
	mov ah, 0x00
	mov al, 0x03
	int 0x10
	popa
; ---------------------------------------------------------------------------------




; -------------------------- Display Primes Label ---------------------------------------
mov si, primes
call print_primes
jmp $
primes db 'Primes: ', 0xa, 0xd,  0
	
print_primes:
	mov ah, 06h
	mov bh, 2Ch
	int 10h
	mov ah, 0Eh

.repeat_primes:
	lodsb
	cmp al, 0
	je .done_primes
	int 10h
	jmp .repeat_primes

	
.done_primes:
; ---------------------------- Naive Display Primes -------------------------------


mov si, prime_2
call print_2
jmp $
prime_2 db '2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71', 0xa, 0xd, 0

print_2:
	mov ah, 0Eh

.repeat_prime_2:
	lodsb 
	cmp al, 0
	je .done_prime_2
	int 10h
	jmp .repeat_prime_2

.done_prime_2:
ret
; ---------------------------------------------------------------------------------


TIMES 510 - ($-$$) db 0				; make sure length is 512 bytes
DW 0xAA55							; boot signature 
