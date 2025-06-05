.data
newline: .asciiz "\n"

.text
.globl main

main:
    li $a0, 6              # Calcular fib(n)
    jal fib                # Llamar a la función fib
    move $a0, $v0          # Mover el resultado a $a0 para imprimir
    li $v0, 1              # syscall: imprimir entero
    syscall

    li $v0, 4              # syscall: imprimir salto de línea
    la $a0, newline
    syscall

    li $v0, 10             # syscall: salir del programa
    syscall

# Función recursiva: int fib(int n)
fib:
    addi $sp, $sp, -12     # Reservar espacio para $ra, $a0, $t0
    sw $ra, 8($sp)         # Guardar dirección de retorno
    sw $a0, 4($sp)         # Guardar argumento n
    sw $t0, 0($sp)         # Guardar $t0 (importante en recursión)

    li $t1, 1
    ble $a0, $t1, base_case  # Si n <= 1, ir al caso base

    # fib(n-1)
    addi $a0, $a0, -1
    jal fib
    move $t0, $v0          # Guardar fib(n-1) en $t0

    # fib(n-2)
    lw $a0, 4($sp)         # Restaurar n original
    addi $a0, $a0, -2
    jal fib
    add $v0, $v0, $t0      # v0 = fib(n-1) + fib(n-2)
    j end_fib

base_case:
    move $v0, $a0          # Retornar n (0 o 1)

end_fib:
    lw $t0, 0($sp)         # Restaurar $t0
    lw $a0, 4($sp)         # Restaurar $a0
    lw $ra, 8($sp)         # Restaurar $ra
    addi $sp, $sp, 12      # Liberar espacio en la pila
    jr $ra                 # Volver
