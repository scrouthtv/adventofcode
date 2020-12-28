%include "numprint.asm"
%include "qwarray.asm"

section .text
	global _start

_start:
	mov eax, 0
	call init							; init the list / array
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

	; current seat is in eax, 
	call put	; store it in the array

	xor eax, eax
	mov dword [info], 0

	jmp nextpart

exit:
	; close the file:
	mov eax, 6						; sys_close
	xor ebx, ebx
	mov bl, [fd]					; copy fd into ebx: ebx = *fd
	int 0x80

	xor eax, eax
	mov [searchseat], eax	; begin with seat #0
	searchloop:
	mov eax, [searchseat]
	inc eax								; search for the next seat
	mov [searchseat], eax	; this will not work if we're looking for #0
	iterloop:
	call next
	mov eax, [eax]				; save this iteration's value into eax
	cmp eax, [searchseat]	; compare this iteration's value to searchseat
	je searchloop					; check for the next seat

	call hasnext					; if there are no seats left, searchseat is missing
	cmp eax, [true]
	jne foundnexit
	jmp iterloop					; if there are seats left, go for the next seat

	foundnexit:
	mov eax, [searchseat]
	mov [number], eax
	call print_dec

	mov eax, 1						; sys_exit
	int 0x80
	
section .data
	file db "/home/lenni/git/adventofcode/05/input"
	len equ $ - file

section .bss
	info resb 12	; reading into this overwrites earlier variables
								; so better define all afterwards:
	searchseat resq 1
	found resb 1
	fd resb 1
