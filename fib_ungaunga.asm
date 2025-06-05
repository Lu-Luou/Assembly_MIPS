.data
n:          .word 6             # Cantidad de términos a calcular
fibonacci:  .space 40            # Espacio para 10 palabras (10 * 4 bytes)

.text
.globl main

main:
    lw $t0, n                    # Cargar n en $t0
    addi $t0, $t0, 1			 # n + 1 para facilitar el printeo (hace un calculo de más)

    li $t1, 0                    # $t1 = i (contador)
    li $t2, 0                    # $t2 = F(0)
    li $t3, 1                    # $t3 = F(1)
    la $t4, fibonacci            # Dirección base del array fibonacci

loop:
    beq $t1, $t0, end            # Si i == n, terminar

    # Guardar el término actual en memoria
    sw $t2, 0($t4)

    # Calcular el siguiente término
    add $t5, $t2, $t3            # t5 = F(i) + F(i+1)
    
    # Actualizar F(i) y F(i+1)
    move $t2, $t3                # F(i) = F(i+1)
    move $t3, $t5                # F(i+1) = F(i) + F(i+1)

    # Incrementar dirección y contador
    addi $t4, $t4, 4             # Avanzar al siguiente espacio en el array
    addi $t1, $t1, 1             # i++

    j loop

end:
    addi $t4, $t4, -4
    lw $a0, 0($t4)
    li $v0, 1
    syscall
    
    li $v0, 10                   # Salida del programa
    syscall
