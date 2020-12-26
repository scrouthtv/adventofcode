section .text
	global _start

_start:
	mov eax, 1
	; open the file:
	mov eax, 5						; sys_open
	mov ebx, file					; filename
	mov ecx, 0						; read-only access
	mov edx, 0777					; rwxrwxrwx
	int 0x80
	mov [fd], eax					; copy eax into fd: &fd = eax

nextpart:

	; read from file:
	mov eax, 3						; sys_read
	mov ebx, [fd]
	mov ecx, info					; info points to the memory location of the buffer
	mov edx, 11						; buffer size
	int 0x80
	
	cmp eax, 11						; has the full file been read?
	je keepreading
	
	mov eax, 0
	mov [readagain], eax	; set readagain to false

keepreading:

	mov ecx, info					; ecx points to the current element
	mov [currseat], ecx		; also store it at the address of currseat

nextseat:
	mov eax, 0						; reset seat to 0
	mov ecx, [currseat]		; retrieve current character address from currseat

top:
	cmp byte [ecx], 0xa
	je  end
	shl eax, 1						; shift to the left
	cmp byte [ecx], 'F'
	je  lower
	cmp byte [ecx], 'L'
	je  lower

	add eax, 1						; take the higher half

lower:
	inc ecx								; next character
	jmp top								; loop

end:
	inc ecx
	mov [currseat], ecx		; save current character after reading for later use
	mov word [number], ax	; save the calculated number for print_dec
	call print_dec

	mov eax, currseat
	sub eax, info					; check how many characters we're interpreted
	cmp eax, 0
	jg nextseat

	cmp byte [keepreading], 1	; keep reading == true?
	je nextpart

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
