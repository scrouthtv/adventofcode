%include "numprint.asm"

section .text
	global _start

_start:
	mov eax, 0
	mov [maxseat], eax
	mov [fd], al

	; open the file:
	mov eax, 5						; sys_open
	mov ebx, file					; filename
	mov ecx, 0						; read-only access
	mov edx, 0777					; rwxrwxrwx
	int 0x80
	mov [fd], al					; copy eax into fd: &fd = eax

nextpart:

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	; read from file:
	mov eax, 3						; sys_read
	mov bl, [fd]
	mov ecx, info					; info points to the memory location of the buffer
	mov edx, 11						; buffer size
	int 0x80
	
	cmp eax, 11						; has the full file been read?
	jne exit							; leave if there isn't a full record left
	
	mov ecx, info					; ecx points to the current element
	mov eax, 0						; reset seat to 0

	mov edx, 0

top:
	cmp byte [ecx], 0xa
	je  endofthisseat
	shl eax, 1						; shift to the left
	cmp byte [ecx], 'F'
	je  lower
	cmp byte [ecx], 'L'
	je  lower

	add eax, 1						; take the higher half

lower:
	mov byte [ecx], dl		; clear this character
	inc ecx								; next character
	jmp top								; loop

endofthisseat:

	cmp word ax, [maxseat]
	jle notbigger
	mov [maxseat], ax			; the current one is greater, save it
notbigger:

	;mov word [number], ax	; save the calculated number for print_dec
	;call print_dec

	mov eax, 0
	mov dword [info], 0

	jmp nextpart

exit:
	; close the file:
	mov eax, 6						; sys_close
	xor ebx, ebx
	mov bl, [fd]					; copy fd into ebx: ebx = *fd
	int 0x80

	mov word ax, [maxseat]
	mov word [number], ax	; save the calculated number for print_dec
	call print_dec

	; exit:
	mov eax, 1						; sys_exit
	int 0x80
	
section .data
	file db "/home/lenni/git/adventofcode/05/input"
	len equ $ - file

section .bss
	info resb 12	; reading into this overwrites earlier variables
								; so better define all afterwards:
	fd resb 1
	maxseat resw 1
