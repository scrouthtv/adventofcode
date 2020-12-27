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

	mov eax, 3
	call get ; eax should now be 3
	mov [number], ax
	call print_dec

	mov eax, 0
	call get ; eax should now be 0
	mov [number], ax
	call print_dec

	mov eax, 95
	call get ; eax should now be 95
	mov [number], ax
	call print_dec

	mov eax, 112
	call get ; eax should now be 112
	mov [number], ax
	call print_dec

	mov eax, 148
	call get ; eax should now be 148
	mov [number], ax
	call print_dec

	mov eax, 149
	call get ; eax should now be 149
	mov [number], ax
	call print_dec

	mov eax, 150
	call get ; eax should now be 150
	mov [number], ax
	call print_dec
	
  mov	eax, 1				; system call number (sys_exit)
  int	0x80					; call kernel

section .bss
	counter resq 1
