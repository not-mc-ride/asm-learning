; initialize data segment
segment .data
    num1 db 10
    num2 db 10
    msg db "hell"
    msg_len equ $ - msg
    exit_code equ 60
    exit_call equ 1
    SYS_write equ 1         ; define SYS_write as constant and set its value to 1

segment .bss
    result resb 8
    retadr resb 8
; initialize code segment
segment .text
    global _start

; _start function - entry point for the program
_start:
    mov ah, [num1]      ; move num1 to dx register
    add ah, [num2]      ; add num2 to dx register
    
    
    mov dh, 10   ; set rbx to the divisor
    call exit
    idiv ah      ; rax is now divided by rbx
    add ah, 48
    mov [result], ah
    call print
    call exit


print:
    mov rdi, 1          ; specify file descriptor for standard output
    lea rsi, [result]         ; load address of msg into ecx
    mov rdx, 2    ; specify length of data to be written
    mov rax, SYS_write  ; specify syscall number for write
    syscall
    ret
    
exit:
    mov rax, exit_code
    mov rsi, exit_call
    syscall 
