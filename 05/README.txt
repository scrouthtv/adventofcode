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

For pt 2 I couldn't think of another way than 
 a) read the source file n times to check for each number
 b) store each seat in a list and check that list
(a) seemed stupid, so I implemented a variable-length list that uses sys_brk to allocate memory during runtime. It's a poor implementation and def not production-ready, but it works well enough for me.
From there on, I have two possibilities:
 ba) sort the array and check for the first missing value
 bb) just blindly test each entry
Now, theoretically, with (ba), I would've gotten a faster runtime bc things like HeapSort and the like only require n log n, however, I don't want to implement that thing, and BubbleSort takes n^2, the same time as (bb).
See file1.asm for how the loop and loop and loop and loop approach looks.

The files are:
 - numprint: where I wrote a library to actually print the number in the end
 - numprint_test: testing that library

 - qwarray: where I wrote a library that naively implements a valid-sized list of qwords

 - file0: the first attempt at the task

Some test files:
 - test0: me testing out io
 - test1: me testing out registers
 - test2: me testing out different sized registers
 - test3: me testing out division
 - pp: me testing out the push/pop commands

Also, at some places there are true's and false's, I understand that that's not a real concept in a low-level language. However, it makes the code so much more readable if I don't rely on testing for 0s and 1s here and there.
