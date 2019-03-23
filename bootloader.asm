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

TIMES 510 - ($-$$) db 0				; make sure length is 512 bytes
DW 0xAA55							; boot signature

; ---








; ---- OS PART ----



; ---- OS PART ----

