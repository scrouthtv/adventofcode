section	.text
  global _start
	
_start:
	mov eax, 0
	mov ax, 5
	
  mov	eax, 1			; sys_exit
  int	0x80     ;call kernel
	
section	.data
	a db 178
