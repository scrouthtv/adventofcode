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

The files are:
 - numprint: where I wrote a library to actually print the number in the end
 - numprint_test: testing that library

 - file0: the first attempt at the task

Some test files:
 - test0: me testing out io
 - test1: me testing out registers
 - test2: me testing out different sized registers
 - test3: me testing out division
