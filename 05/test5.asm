section	.bss
	head resq 4				; three qwords

section	.text
  global _start
	
_start:

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx			; counter = 0

	mov eax, head			; move the address of head into eax: eax -> 0
	mov ebx, eax			; eax -> 0
	add ebx, 12				; ebx -> 3
	mov [ebx], eax		; 3 -> 0

	loop:							; first run		second run
	inc ecx						; counter = 0 counter = 1
	mov ebx, eax			; ebx -> 0		ebx -> 1
	add eax, 4				; eax -> 1		eax -> 2
	mov [ebx], eax		; 0 -> 1			1 -> 2
	cmp	ecx, 3				; ecx = 1 < 2	ecx = 2 == 2
	jl loop

	mov eax, head			; eax points to the first element
	
  mov	eax,1					; system call number (sys_exit)
  int	0x80					; call kernel
