section .text
; function used to print the decimal number of the word in number,
print_dec:
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	mov word [digit], 10000	; start with the highest digit
	mov eax, 0							; clear eax

loop:
	mov ax, [number]				; divide number
	div word [digit]				; by digit

	mov [number], dx				; store remainder in number
	add eax, '0'
	mov [msg], eax

	; print this digit:
	mov ecx, msg						; message
	mov edx, 1							; length
	mov ebx, 1							; stdout
	mov eax, 4							; sys_write
	int 0x80

	xor eax, eax						; for some reason, i have to
	xor edx, edx						; clear these first
	mov ax, [digit]					; divide digit
	mov bl, 10
	div ebx									; by 10
	mov [digit], ax					; store this new digit
	
	cmp word [digit], 0
	jne loop 

	ret											; return if there are no more valid digits left

; end print_dec

section .bss
	digit resw 1
	number resw 1
	msg resw 1

section .data
