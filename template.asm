; x86 assembly program template for Linux

; initialize data segment
segment .data

    exit_code equ 60
    exit_call equ 1
    SYS_write equ 1         ; define SYS_write as constant and set its value to 1

; initialize code segment
segment .text
    global _start

; _start function - entry point for the program
_start:

    mov rax, exit_code
    mov rsi, exit_call
    syscall
