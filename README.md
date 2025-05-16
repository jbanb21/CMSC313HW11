To Compile and Run:
  
nasm -f elf32 hw11translate2Ascii.asm -o hw11translate2Ascii.o/hw11translate2

ld -m elf_i386 hw11translate2Ascii.o -o hw11translate2Ascii

./hw11translate2Ascii
