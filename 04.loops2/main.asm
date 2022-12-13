; initialize data segment
segment .data
    msg: db "hello world"
    msg_len equ $ - msg
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

exit:
    mov rax, exit_code
    mov rsi, exit_call
    syscall  

print:                      ; define a print function 
    pop rcx                 ; pop the return address to rcx
    mov [retadr], rcx       ; move the contents of rcx to retadr
    mov rdi, 1              
    pop rdx                 ; pop msg to rdx
    pop rsi                 ; pop msg_len to rsi
    mov rax, SYS_write      
    syscall
    call exit               ; call exit function
   
