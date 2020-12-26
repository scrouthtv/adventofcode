section .text
	global _start

_start:
	mov word [number],357

	mov eax, 1
	int 0x80

section .bss
	number resw 1

section .data
	mynum dw 357
