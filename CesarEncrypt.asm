.data
	key: .ascii "QWERTYUIOPASDFGHJKLZXCVBNM" 
	chain: .asciiz "HOLA"
	cipher: .space 5
	
.text
	la $t0, key
	la $t1, chain
	la $t2, cipher
	
	cifrar:
  		lb $t3, 0($t1)     
    	beq $t3, $zero, fin      

    	li $t4, 'A'        
    	sub $t5, $t3, $t4  

    	add $t6, $t0, $t5  
    	lb $t7, 0($t6)     

    	sb $t7, 0($t2)     

    	addi $t1, $t1, 1   
    	addi $t2, $t2, 1   
    	j cifrar
		
	fin:
    	li $v0, 4
    	la $a0, cipher
   		syscall

  		li $v0, 10
  		syscall