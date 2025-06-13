.data
m:      .word 3      # Cambia estos valores para probar otros casos
n:      .word 2
result: .word 0
msg:    .asciiz "Resultado: "

.text
.globl main

main:
    lw $a0, m
    lw $a1, n
    jal ackermann

    sw $v0, result

    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 1
    lw $a0, result
    syscall

    li $v0, 10
    syscall

ackermann:
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $a0, 4($sp)
    sw $a1, 0($sp)

    # caso base m == 0
    beqz $a0, ack_m0

    # m > 0 y n == 0
    beqz $a1, ack_n0

    # m > 0 y n > 0
    addi $a1, $a1, -1       # n-1
    jal ackermann           # ackermann(m, n-1) -> $v0

    lw $a0, 4($sp)          # m
    addi $a0, $a0, -1       # m-1
    move $a1, $v0           # resultado anterior
    jal ackermann
    j ack_end

ack_m0:
    lw $a1, 0($sp)
    addi $v0, $a1, 1
    j ack_end

ack_n0:
    lw $a0, 4($sp)
    addi $a0, $a0, -1
    li $a1, 1
    jal ackermann

ack_end:
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra
