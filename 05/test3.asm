section .text
	global _start

_start:
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	mov ax, 10000						; divide digit
	mov bx, 10
	div ebx									; by 10
	
	mov eax, 1
	int 0x80

section .bss

section .data
