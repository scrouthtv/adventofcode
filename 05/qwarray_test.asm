%include "qwarray.asm"
%include "numprint.asm"

section .text
	global _start

_start:

	call init
	
	mov eax, 150

	startloop:
	mov [counter], eax	; save counter
	mov ebx, 2
	mul ebx
	call put
	mov eax, [counter]	; restore counter
	dec eax
	cmp eax, 0
	jg startloop

	call iterreset
	iterloop:
	call next
	mov eax, [eax]
	mov [number], ax
	call print_dec
	call hasnext
	cmp eax, [true]
	je iterloop

	
  mov	eax, 1				; system call number (sys_exit)
  int	0x80					; call kernel

section .bss
	counter resw 1
