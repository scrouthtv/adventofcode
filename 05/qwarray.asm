; Implements a very basic and naive
; runtime-resizable qword (4*byte) value-containing array
; Indexes can go up to 4,294,967,295

section	.text
  global _start
	
_start:

	call init
	
	mov eax, 17
	call put
	
  mov	eax, 1				; system call number (sys_exit)
  int	0x80					; call kernel

init:
	mov eax, 50
	mov [free], eax
	mov eax, 0
	mov [used], eax
	mov [error], al

	; initialize the first block:
	; every second cell (2n) should point to the second-next cell,
	; the second-to-last cell remains uninitialized
	; 2n+1 remains uninitialized as well

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx			; set counter to 0
	
	mov eax, head			; load address of head into eax

	init_loop:
		inc ecx   			; increase counter

		mov ebx, eax		; eax contains the next address from last run = 
										; the current address from this run

		add eax, 8			; set ebx to the next address from this run

		mov [ebx], eax 	; this writes the content of ebx at the address in eax
										; ebx contains the next address, eax the current address,
										; every cell should point to the next cell

		cmp ecx, 49				; if we haven't written 98/2 pointers
	jle init_loop 			; do the next cell

	xor eax, eax			; clear return
	mov [error], eax	; clear error
	ret

; appends the value in eax at the end
put:
	mov eax, free
	cmp eax, 0
	jg noinc
	call inc_size
	noinc:

	mov eax, [used]
	call nth_block
	inc eax
	mov [eax], edx
	ret

; Only call inc_size if there is no memory left:
inc_size:
	mov eax, [used]		; get the address of the last cell
	call nth_block
	mov edx, eax			; edx is the top address of the last cell

	mov eax, [sys_brk]; sys_brk
	mov ebx, 160			; allocate 20 * 2 dwords (20 * 2 * 4 bytes)
	int 0x80					; call sys_brk
	; now, eax points to the first element of the new block

	mov [edx], eax		; the last old cell 

	; now init the new block:
	mov eax, [free]		; more memory is free now
	add eax, 20
	mov [free], eax

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx			; set counter to 0
	inc_size_loop:
		inc ecx
		mov ebx, eax		; eax contains the next address from the last run
										; = the current address from this run
		add eax, 8			; set ebx to the next address
		mov [ebx], eax	; write the content of eax (the next address) into 
										; the address in ebx (the current address)
		cmp ecx, 19			; have we initialized all 19 cells?
	jle inc_size_loop
	ret

; Returns the top pointer to the nth element, n is stored in eax
; ebx and edx stay unchanged
nth_block:
	cmp eax, [used]		; return if the requested element isn't set yet
	jg nth_block_err_oob

	mov ecx, eax
	mov eax, head
	nth_loop:
	cmp ecx, 0				; if we're already there, exit
	je nth_loop_end

	mov eax, [eax]		; go to the next element
	add ecx, 1				; increment counter by one
	nth_loop_end:
	ret

	nth_block_err_oob:
	mov eax, [err_oob]
	mov [error], al
	xor edx, edx
	ret
	
section	.bss
	free resb 1				; how many dwords are free
	used resq 1				; how many dwords are used
	head resq 100			; the first *fifty* elements
	error resb 1			; the last error

section .data
	sys_brk dw 45
	err_oob db 1			; error: out of bounds
