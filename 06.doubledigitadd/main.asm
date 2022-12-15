; initialize data segment
segment .data
    num1 db 2
    num2 db 1
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
    
    
    mov rax, dx   ; move the value in dx into rax
    mov rbx, 10   ; set rbx to the divisor
    idiv rbx      ; rax is now divided by rbx
    mov dx, rax   ; move the quotient back into dx
    
    add dx, 48
    mov [result], dx
    call print
    
    mov rax, exit_code
    mov rsi, exit_call
    syscall  
    
print:
    mov rdi, 1          ; specify file descriptor for standard output
    lea rsi, [result]         ; load address of msg into ecx
    mov rdx, 2    ; specify length of data to be written
    mov rax, SYS_write  ; specify syscall number for write
    syscall
    ret