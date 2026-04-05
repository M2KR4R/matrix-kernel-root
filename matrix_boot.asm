; - Matrix Kernel - System Entry Point - 

section .data
msg     db "Matrix does not have me. I have the root access.", 10
msg_len equ $ - msg

section .text
global _start

_start:
    ; --- write(1, msg, msg_len) ---
    mov rax, 1                ; syscall: write
    mov rdi, 1                ; file descriptor: stdout
    lea rsi, [rel msg]        ; RIP-relative addressing (PIE safe)
    mov rdx, msg_len          ; message length
    syscall

    ; --- error check: if write returns negative, exit with 1 ---
    test rax, rax
    jns .write_ok             ; if rax >= 0, success
    mov rdi, 1                ; failure exit code
    jmp .exit

.write_ok:
    xor rdi, rdi              ; exit code 0

.exit:
    mov rax, 60               ; syscall: exit
    syscall
