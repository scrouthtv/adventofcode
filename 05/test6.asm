section .text
	global _start

_start:
	mov eax, 10
	mov [total], eax

	mov eax, 3
	mov [used], eax

	mov eax, [total]
	cmp eax, [used]
	je inca
	call noinc
	jmp testb
	inca:
	call doinc

	testb:
	mov eax, 10
	mov [used], eax

	mov eax, [total]
	cmp eax, [used]
	je incb
	call noinc
	jmp exit
	incb:
	call doinc

	exit:
	mov eax, 1
	xor ebx, ebx
	int 0x80

doinc:
	mov edx, inclen
	mov ecx, incmsg
	mov ebx, 1
	mov eax, 4
	int 0x80
	ret

noinc:
	mov edx, nnclen
	mov ecx, nncmsg
	mov ebx, 1
	mov eax, 4
	int 0x80
	ret


section .data
	incmsg db 'Going to increase', 0xa 
	inclen equ $ - incmsg
	nncmsg db 'Not going to increase', 0xa
	nnclen equ $ - nncmsg

section .bss
	total resq 1
	used resq 1
