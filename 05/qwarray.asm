; Implements a very basic and naive
; runtime-resizable qword (4*byte) value-containing array
; Indexes can go up to 4,294,967,295

section	.text
	
init:
	mov eax, 5
	mov [total], eax
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
	mov [iterator], eax

	init_loop:
		inc ecx   			; increase counter

		mov ebx, eax		; eax contains the next address from last run = 
										; the current address from this run

		add eax, 8			; set ebx to the next address from this run

		mov [ebx], eax 	; this writes the content of ebx at the address in eax
										; ebx contains the next address, eax the current address,
										; every cell should point to the next cell

		cmp ecx, 4 				; if we haven't written 98/2 pointers
	jle init_loop 			; do the next cell

	xor eax, eax			; clear return
	mov [error], eax	; clear error
	ret

; returns the value of the nth element, n being in eax
get: 
	call nth_block
	cmp eax, 0
	je exit_get
	add eax, 4				; add 4 to get the address of the value
	mov eax, [eax]		; this write the value at the address in eax into eax

	xor ecx, ecx
	mov [error], cl		; reset the error

	exit_get:
	ret

; appends the value in eax at the end
put:
	push eax
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	mov eax, [total]
	cmp eax, [used]
	jne noinc
	call inc_size
	noinc:

	pop edx
	mov eax, [used]
	call nth_block
	add eax, 4
	mov [eax], edx
	mov eax, [used]
	inc eax
	mov [used], eax
	ret

; Only call inc_size if there is no memory left:
; Returns false on fail, true on success
inc_size:

	xor eax, eax
	mov ax, [sys_brk]	; sys_brk
	xor ebx, ebx
	int 0x80					; now eax contains the bottom of the current heap

	add eax, 160			; reserve 20 * 2 qwords = 20 * 2 * 4 bytes
	mov ebx, eax
	xor eax, eax
	mov ax, [sys_brk]
	xor ecx, ecx
	xor edx, edx
	int 0x80					; now eax contains the top of the new heap

	cmp eax, 0				; memory is unitialized for now,
	jl incerr					; imma pretend I didn't see that

	push eax					; save new top
	mov eax, [used]		; get the address of the last cell
	sub eax, 1
	call nth_block		; eax is now the address of the last index cell
	pop edx
	mov [eax], edx		; append new block at the end of the old block

	; now init the new block:
	mov eax, [total]		; more total memory now available
	add eax, 20
	mov [total], eax

	mov eax, edx
	xor edx, edx
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

	incerr:
	mov eax, [err_mem]
	mov [error], eax
	mov eax, [false]
	ret

; Iterator functionality:
hasnext:
	mov eax, [itern]
	cmp eax, [used] 
	jg hasnonext

	mov eax, [true]
	ret

	hasnonext:
	mov eax, [false]
	ret

; Returns the address to the next element, only call this if
; hasnext returns true
next:
	mov eax, [itern]
	inc eax
	mov [itern], eax
	mov eax, [iterator]
	mov eax, [eax]
	mov [iterator], eax
	sub eax, 4					; point to the value
	ret
	
iterreset:
	mov eax, head
	mov [iterator], eax
	mov eax, 0
	mov [itern], eax
	ret

; Returns the top pointer to the nth element, n is stored in eax
; ebx and edx stay unchanged
nth_block:
	cmp eax, [used]		; return if the requested element isn't set yet
	jg nth_block_err_oob

	mov ecx, eax			; ecx = n
	mov eax, head			; eax -> 0
	nth_loop:
	cmp ecx, 0				; if we're already there, exit
	je nth_loop_end

	mov eax, [eax]		; go to the next element
	dec ecx						; decrement counter by one
	jmp nth_loop
	nth_loop_end:
	ret

	nth_block_err_oob:
	mov eax, [err_oob]
	mov [error], al
	xor eax, eax
	ret
	
section	.bss
	total resq 1			; how much total memory is assigned
	used resq 1				; how many dwords are used
	head resq 10			; the first *fifty* elements
	error resb 1			; the last error
	iterator resq 1		; iterator address
	itern resq 1			; iterator n

section .data
	sys_brk dw 45
	err_oob db 1			; error: out of bounds
	err_mem db 2			; error assigning memory
	false dw 0
	true dw 1
