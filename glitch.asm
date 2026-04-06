 ; - Matrix Kernel - Glitch / Déjà Vu -

section .data write          
msg     db "SYSTEM_STABLE", 10
msg_len equ $ - msg

section .text
global _start

_start:
    
    xor r8, r8                

.sequence:
    mov rax, 1                
    mov rdi, 1                
    lea rsi, [rel msg]        
    mov rdx, msg_len          
    syscall

    test rax, rax
    js .exit                  
    cmp r8, 1
    je .write_ok              

    ; --- THE GLITCH

    lea rbx, [rel msg]
    xor byte [rbx + 7], 0x20  
    
    inc r8
    jmp .sequence             ; DÉJÀ VU

.write_ok:
    xor rdi, rdi              

.exit:
    mov rax, 60               
    syscall
