Here is a little bug I encountered while working on all this.
When I include another file, as in somefile_test.asm
the line numbers in nasm's debugging information are off by one.
https://bugzilla.nasm.us/show_bug.cgi?id=3392731

I fixed this for now by building source, 2.16rc0 @ dc4a19 seems to be working for now.
