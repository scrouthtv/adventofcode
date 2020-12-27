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

funca:
	mov eax, 5
	mov ebx, 5
	cmp eax, ebx
	je aisequal
	mov ecx, 13
	mov edx, 19
	ret

	aisequal:
	mov ecx, 17
	mov edx, 21
	ret
