%include "somefile.asm"

section .text
	global _start

_start:
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	call funca

	mov eax, 1
	mov ebx, 0
	int 0x80
