.data
    Msg: .asciiz "Enter a number to find its factorial: "
    resultMsg: .asciiz "\nResult: "
    n: .word 4
    result: .word 4

.text
.globl main

main:
    li $v0, 4
    la $a0, Msg
    syscall

    li $v0, 5
    syscall

    sw $v0, n

    lw $a0, n
    jal factorial

    sw $v0, result

    li $v0, 4
    la $a0, resultMsg
    syscall

    li $v0, 1
    lw $a0, result
    syscall

    li $v0, 10
    syscall

factorial:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    li $v0, 1
    beq $a0, 0, factorial_end

    addi $a0, $a0, -1
    jal factorial

    lw $a0, 0($sp)
    mul $v0, $v0, $a0

factorial_end:
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra