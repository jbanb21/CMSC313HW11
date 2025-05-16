section .data
    inputBuf db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
    inputLen equ 8

    hexChars db "0123456789ABCDEF"

section .bss
    outputBuf resb 80

section .text
    global _start

_start:
    mov ecx, 0              ; input index
    mov edi, outputBuf      ; output pointer

translate_loop:
    cmp ecx, inputLen
    jge finish_buffer

    ; Load input byte
    movzx eax, byte [inputBuf + ecx]

    ; High nibble
    mov ebx, eax
    shr ebx, 4
    mov bl, [hexChars + ebx]
    mov [edi], bl
    inc edi

    ; Low nibble
    and eax, 0x0F
    mov al, [hexChars + eax]
    mov [edi], al
    inc edi

    ; Add space
    mov byte [edi], ' '
    inc edi

    inc ecx
    jmp translate_loop

finish_buffer:
    ; Overwrite last space with newline
    dec edi
    mov byte [edi], 10      ; '\n'

    ; Compute output length in edx
    mov eax, edi
    sub eax, outputBuf
    mov edx, eax            ; length = edi - outputBuf

    ; Write buffer to stdout
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, outputBuf
    int 0x80

    ; Exit
    mov eax, 1              ; sys_exit
    xor ebx, ebx
    int 0x80
