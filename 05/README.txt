NOTES
=====

Compile using nasm:

nasm -f elf -g -F dwarf file0.asm
ld -m elf_i386 -o file0.out file0.o
gdb file0.out

Everything is written in x32.

Up until two days ago I didn't know anything about assembly, my sources:

 - https://tutorialspoint.com/assembly_programming/assembly_registers.htm
 - https://i8086.de/asm/8086-88-asm-div.html
 - StackExchange
 - http://asciitable.com/
