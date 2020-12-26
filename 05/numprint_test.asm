%include "numprint.asm"

section .text
	global _start

_start:
	mov word [number], 357
	call print_dec

	mov eax, 1
	mov ebx, 0
	int 0x80
