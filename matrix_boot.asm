; - Matrix Kernel - System Entry Point - 

section .data
msg     db "Matrix does not have me. I have the root access.", 10
msg_len equ $ - msg

section .text
global _start

_start:
    
    mov rax, 1                
    mov rdi, 1                
    lea rsi, [rel msg]        
    mov rdx, msg_len          
    syscall

   
    test rax, rax
    jns .write_ok             
    mov rdi, 1                
    jmp .exit

.write_ok:
    xor rdi, rdi              

.exit:
    mov rax, 60               
    syscall
