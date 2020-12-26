section .text
	global _start

_start:
	; open the file:
	mov eax, 5						; sys_open
	mov ebx, file					; filename
	mov ecx, 0						; read-only access
	mov edx, 0777					; rwxrwxrwx
	int 0x80
	mov [fd], eax					; copy eax into fd: &fd = eax

nextpart:

	mov eax, 0
	mov [info], eax
	; read from file:
	mov eax, 3						; sys_read
	mov ebx, [fd]
	mov ecx, info					; info points to the memory location of the buffer
	mov edx, 11						; buffer size
	int 0x80
	
	cmp eax, 11						; has the full file been read?
	jne exit

keepreading:

	mov ecx, info
	mov edx, 11
	mov ebx, 1
	mov eax, 4
	int 0x80

	jmp nextpart

exit:

	; close the file:
	mov eax, 6						; sys_close
	mov ebx, [fd]					; copy fd into ebx: ebx = *fd
	int 0x80

	; exit:
	mov eax, 1						; sys_exit
	int 0x80
	
section .data
	file db "/home/lenni/git/adventofcode/05/in1.txt"
	len equ $ - file

section .bss
	fd resb 1
	info resb 11
	myseat resb 1
	max resb 1
	i resb 1
	currseat resb 1
	readagain resb 1
