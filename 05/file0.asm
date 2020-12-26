section .text
	global _start

_start:
	# open the file:
	mov eax, 5				# sys_open
	mov ebx, file			# filename
	mov ecx, 0				# read-only access
	mov edx, 0777			# rwxrwxrwx
	int 0x80
	mov [fd], eax			# copy eax into fd: &fd = eax

	# read from file:
	mov eax, 3				# sys_read
	mov ebx, [fd]
	mov ecx, info
	mov edx, 2048			# buffer size
	int 0x80

	mov ecx, info			# point to the first element
	mov edx, 2048			# how many elements to add

	mov eax, 0				# seat

top:

	cmp byte [ecx], 0xa
	je end
	cmp byte [ecx], 'F'
	je  lower
	cmp byte [ecx], 'L'
	je  lower

	add eax, 1				# take the higher half

lower:

	shl eax, 1				# shift to the
	inc ecx						# next bit

	jmp top

end:
	
	shr eax, 1							# remove the last bit
	mov ecx, eax						# print the line we got
	mov eax, 4
	mov ebx, 1							# to stdout
	mov edx, 1024						# all 1024 characters
	int 0x80

	# close the file:
	mov eax, 6				# sys_close
	mov ebx, [fd]			# copy fd into ebx: ebx = *fd
	int 0x80

	# exit:
	mov eax, 1				# sys_exit
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
