; - Matrix Kernel - The Choice (B/R) -

section .data
    prompt      db "CHOICE_REQUIRED [B/R]: ", 0
    prompt_len  equ $ - prompt
    
    blue_msg    db "RE-INSERTING_TO_SIMULATION...", 10
    blue_len    equ $ - blue_msg
    
    red_msg     db "ESCAPE_SEQUENCE_INITIATED", 10
    red_len     equ $ - red_msg

section .bss
    input resb 2

section .text
global _start

_start:
   
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel prompt]
    mov rdx, prompt_len
    syscall

    
    xor rax, rax
    xor rdi, rdi
    lea rsi, [rel input]
    mov rdx, 2
    syscall

    mov al, [rel input]    

    ; -- BLUE PILL
    cmp al, 'B'
    je .blue_pill
    cmp al, 'b'
    je .blue_pill

    ; -- RED PILL
    cmp al, 'R'
    je .red_pill
    cmp al, 'r'
    je .red_pill

    ; -- INVALID_CHOICE
    jmp .exit

.blue_pill:
    ; -- SYSTEM_RESTORE
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel blue_msg]
    mov rdx, blue_len
    syscall
    
    
    jmp .exit

.red_pill:
    ; -- KERNEL_BREAKOUT
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel red_msg]
    mov rdx, red_len
    syscall

    
    xor rbx, rbx
    inc rbx                 ; rbx = 1
    

.exit:
    mov rax, 60             ; sys_exit
    xor rdi, rdi
    syscall
