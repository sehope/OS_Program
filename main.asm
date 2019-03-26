section .data
Text DB "Welcome to our first Operating System!", 0xa
len  equ $-Text

section .text
	global _start

_start:

	mov edx, len
	mov ecx, Text
	mov ebx, 1
	mov eax, edx
	int 0x80

	xor ah, ah
	mov ax, 13h
	int 10h

	mov eax, 1
	xor ebx, ebx
	int 0x80
