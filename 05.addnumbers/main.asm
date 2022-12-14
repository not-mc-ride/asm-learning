

; x86 assembly program template for Linux

; initialize data segment
segment .data
    num1 db 4
    num2 db 3
    msg db "hell"
    msg_len equ $ - msg
    exit_code equ 60
    exit_call equ 1
    SYS_write equ 1         ; define SYS_write as constant and set its value to 1

segment .bss
    result resb 4
    retadr resb 8
; initialize code segment
segment .text
    global _start

; _start function - entry point for the program
_start:
    mov dx, [num1]
    add dx, [num2]

    add dx, 48
    mov [result], dx
    
    mov rdi, 1          ; specify file descriptor for standard output
    lea rsi, [result]         ; load address of msg into ecx
    mov rdx, 1    ; specify length of data to be written
    mov rax, SYS_write  ; specify syscall number for write
    syscall 

    
    mov rax, exit_code
    mov rsi, exit_call
    syscall    
