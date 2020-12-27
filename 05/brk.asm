section	.text
   global _start
	
_start:

   mov	ebx, 16384	; number of bytes to be reserved
   mov	eax, 45			; sys_brk
   int	0x80
	
   mov	eax, 4
   mov	ebx, 1
   mov	ecx, msg
   mov	edx, len
   int	0x80				; print a message

exit:
   mov	eax, 1
   xor	ebx, ebx
   int	0x80
	
section	.data
msg    	db	"Allocated 16 kb of memory!", 10
len     equ	$ - msg
