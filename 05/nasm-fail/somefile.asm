section .text

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
