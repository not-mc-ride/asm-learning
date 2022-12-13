
; initialize data segment
segment .data
    msg: db "hello world"
    msg_len equ $ - msg
    msg2: db "ello world"
    msg2_len equ $ - msg2
    exit_code equ 60
    exit_call equ 1
    SYS_write equ 1         ; define SYS_write as constant and set its value to 1

segment .bss
    retadr resb 8

; initialize code segment
segment .text
    global _start

; _start function - entry point for the program
_start:
    
    push msg
    push msg_len
    call print
    push msg2
    push msg2_len
    call print
    call exit
exit:
    mov rax, exit_code
    mov rsi, exit_call
    syscall  

print:                      ;define a print function 
    pop rax 
    mov [retadr], rax            
    mov rdi, 1
    pop rdx
    pop rsi 
    mov rax, SYS_write
    syscall
    mov rax, [retadr]
    push rax
    ret