; x86 assembly program template for Linux

; initialize data segment
segment .data
    msg db 'hello'          ; define msg as byte, and set its value to 'hello'
    msg_len equ $ - msg     ; define msg_len as constant and set its value to length of msg
    exit_code equ 60
    exit_call equ 1
    SYS_write equ 1         ; define SYS_write as constant and set its value to 1

; initialize code segment
segment .text
    global _start

; _start function - entry point for the program
_start:
    mov rdi, 1          ; specify file descriptor for standard output
    lea rsi, [msg]      ; load address of msg into ecx
    mov rdx, msg_len    ; specify length of data to be written
    mov rax, SYS_write  ; specify syscall number for write
    syscall 

    mov rax, exit_code
    mov rsi, exit_call
    syscall