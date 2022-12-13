; nasm -f elf64 main.asm && ld  main.o -o  main && ./main

segment .data
    msg db 'hello', 10    
    msg_len equ $ - msg          ; define msg as byte, and set its value to 'hello'
    exit_code equ 60
    exit_call equ 1
    SYS_write equ 1         ; define SYS_write as constant and set its value to 1

; initialize code segment
segment .text
    global _start


; _start function - entry point for the program
_start:

    MOV    CL, 10       ; set loop counter to 10
    jz exit             ; jump to exit if CL is equal to 0
    call    printloop   ; call loop


exit:


printloop:
    mov rdi, 1          ; specify file descriptor for standard output
    lea rsi, [msg]      ; load address of msg into ecx
    mov rdx, msg_len    ; specify length of data to be written
    mov rax, SYS_write  ; specify syscall number for write
    push rcx            ; takes the value of rcx and stores it temporarily in esp
    syscall    ;syscall 
    pop rcx             ; takes the value of esp and puts it in rcx
    dec CL              ; substract one from CL
    jnz printloop       ; jmp to printloop if CL is not equal to 0
    mov eax, 1
    mov rax, exit_code
    mov rsi, exit_call
    syscall 
