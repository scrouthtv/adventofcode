%include "qwarray.asm"
%include "numprint.asm"

section .text
	global _start

_start:

	call init
	
	mov eax, 1005	; 1005 is the magic number. go beyond that and it will crash

	startloop:
	mov [counter], eax	; save counter
	mov ebx, 2
	mul ebx
	call put
	;mov edx, [error]		also 0
	;cmp edx, 0
	;jnz errstart
	mov eax, [counter]	; restore counter
	dec eax
	cmp eax, 0
	jg startloop

	;mov eax, 42
	;call put

	;call iterreset
	;iterloop:
	;call next
	;call next
	;call next
	;call next
	;mov eax, [eax]
	;mov [number], ax
	;call print_dec
	;call hasnext
	;cmp eax, [true]
	;je iterloop

	mov eax, 17
	call get
	mov [number], ax
	call print_dec
	mov eax, 399
	call get
	mov [number], ax
	call print_dec
	
  mov	eax, 1				; system call number (sys_exit)
  int	0x80					; call kernel

section .bss
	counter resw 1
