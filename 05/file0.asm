%include "numprint.asm"

section .text
	global _start

_start:
	; open the file:
	mov eax, 5				; sys_open
	mov ebx, file			; filename
	mov ecx, 0				; read-only access
	mov edx, 0777			; rwxrwxrwx
	int 0x80
	mov [fd], eax			; copy eax into fd: &fd = eax

	; read from file:
	mov eax, 3				; sys_read
	mov ebx, [fd]
	mov ecx, info
	mov edx, 2048			; buffer size
	int 0x80

	;mov edx, 2048			; how many elements to add
	mov byte [currseat], al

nextseat:
	mov ecx, info			; point to the first element
	mov eax, 0				; reset seat to 0
	xor ebx, ebx
	xor edx, edx

top:

	cmp byte [ecx], 0xa
	je  end
	cmp byte [ecx], 'F'
	je  lower
	cmp byte [ecx], 'L'
	je  lower

	add eax, 1				; take the higher half

lower:

	shl eax, 1				; shift to the
	inc ecx						; next bit

	jmp top

end:
	
	shr eax, 1
	mov word [number], ax
	call print_dec

	mov al, [currseat]
	inc ax
	mov [currseat], ax
	jmp nextseat

	; close the file:
	mov eax, 6				; sys_close
	mov ebx, [fd]			; copy fd into ebx: ebx = *fd
	int 0x80

	; exit:
	mov eax, 1				; sys_exit
	int 0x80
	
section .data
	file db "/home/lenni/git/adventofcode/05/in1.txt"
	len equ $ - file

section .bss
	fd resb 1
	info TIMES 1024 resb 0
	myseat resb 1
	max resb 1
	i resb 1
	currseat resb 1
