; initialize data segment
segment .data
    msg: db "hello world"
    msg_len equ $ - msg
    msg2: db "ello world"
    msg2_len equ $ - msg2
    nline: db 10
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
    
    push msg               ; send msg to the top of the stack
    push msg_len
    call print
    call newline
    push msg2
    push msg2_len
    call print             ; call print function after pudhing both the message and the message length
    call exit              ; call exit function at the end of the program
exit:                      ; create exit function modtly for cleaner code
    mov rax, exit_code
    mov rsi, exit_call
    syscall  

newline:
    mov rax, 1
    mov rsi, nline
    mov rdi, 1
    mov rdx, 1
    syscall
    ret

print:                      ; define a print function 
    pop rax                 ; pop the return address to rax
    mov [retadr], rax       ; move the return address to a variable, since i use rax later in the function     
    mov rdi, 1
    pop rdx
    pop rsi 
    mov rax, SYS_write
    syscall
    mov rdi,1
    mov rax, [retadr]
    push rax                ; push rax to the top of the stack, since thats what ret uses to know where to return
    ret                     ; return to main loop
