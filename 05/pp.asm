section .text
	global _start

_start:
	mov eax, 9
	mov ebx, 8
	mov ecx, 7
	mov edx, 6

	push eax
	push ebx
	push ecx
	push edx

	call myfunc

	pop edx
	pop ecx
	pop ebx
	pop eax

	mov eax, 1
	xor ebx, ebx
	int 0x80

myfunc:
	mov eax, 98352
	mov ebx, 19298
	mov ecx, 63849
	mov edx, 87325
	ret
