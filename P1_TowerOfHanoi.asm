.data
	Tower1: .word 0x0 	# will be stored in s5
	Tower2: .word 0x0 	# will be stored in s6
	Tower3: .word 0x0 	# will be stored in s7
	
.text 
	main:
	 	addi $s4, $zero, 8	# numberOfDiscs
	 	add $t0, $zero, $s4 	# n=numberOfDiscs
	 	
	 	addi $sp, $sp, -28

		 #load address of Tower1 in s5
 		addi $s5, $zero, 0x1001
 		sll $s5, $s5, 16
 		add $t2, $s5, $zero	
 		
 		#load address of Tower2 in s6
 		addi $s6, $zero, 0x1001
 		sll $s6, $s6, 16
 		addi $s6, $s6, 0x0020
 		
   		#load address of Tower3 in s7
 		addi $s7, $zero, 0x1001
 		sll $s7, $s7, 16
 		addi $s7, $s7, 0x0040
 		
 		add $a1, $s5, $zero	#Base address of Tower1
 		add $a2, $s6, $zero	#Base address of Tower2
 		add $a3, $s7, $zero	#Base address of Tower3
 				
		jal createFirstTower	
        	addi $s1, $zero, 1 #	s1=1
	        addi $s2, $zero, 3 #	s2=3
        	addi $s3, $zero, 2 #	s3=2  to compare the instructions
        
	        addi $sp, $sp, -32
        	sw $s4, 0($sp)
	        sw $s1, 4($sp)
	        sw $s2, 8($sp)
	        sw $s3, 12($sp)
	        
	        addi $a0, $zero, 1
	        addi $v0, $zero, 2
	        addi $v1, $zero, 3
	        	        
	        jal hanoi	
	        
	        jal end
		
		
#--------------------------------------------------------------------------------------------	
 #	Subroutine that creates and fill the first tower depending of the numer of Discs with a loop.	 
	 createFirstTower:
	 	add $t1, $zero, $s5  #load address of Tower1	 	
	 for:
	 		beq $t0, $zero, endfor  #t0=n
	 		sw $t0, ($t1)       	# store in Tower1 the T0 value (n)
	 		
	 		addi $t0, $t0, -1 	# n--;
	 		addi $t1, $t1, 4	#add 4 bits to the direction
	 		j for	 		
	 endfor:
	  #end of subroutine
	  	addi $t1, $t1, -4	#add 4 bits to the direction
	  	add $s5, $t1, $zero #PFROM = Last position of tower
	 	jr $ra 	

#------------------------------------------------------------------------------------------------
        
        
#----------------HANOI FUNCTION----------------------------------------------------------------        

    hanoi:
        sw $ra, 16($sp)
        lw $s4, 0($sp)
        lw $s1, 4($sp)
        lw $s2, 8($sp)
        lw $s3, 12($sp)
        
        
        bne $s4, $a0, else_ifmove	# if(n !=1) jump to else, if n==1 then do the next line	
        
        #if's para seleccionar el pointer indicado
        jal moveValues
 	
 	lw $ra, 16($sp)
 	
 	addi $sp, $sp, 32	        
        
        jr $ra
        
    else_ifmove:
    
        addi $s4, $s4, -1        
        addi $sp, $sp, -32
        sw $s4, 0($sp)
        sw $s1, 4($sp)
        sw $s3, 8($sp)
        sw $s2, 12($sp)
        sw $ra, 16($sp)
        
        jal hanoi
        
        jal moveValues
        
        addi $s4, $s4, -1
        addi $sp, $sp, -32
        sw $s4, 0($sp)
        sw $s3, 4($sp)
        sw $s2, 8($sp)
        sw $s1, 12($sp)
        sw $ra, 16($sp)
        
        jal hanoi
        

 	lw $ra, 16($sp)
 	
 	addi $sp, $sp, 32
        
        jr $ra
        
        
        
        #-----------------------------------------------------------------------------
        #Move Values
        moveValues:
        lw $s4, 0($sp)
        lw $s1, 4($sp)
        lw $s2, 8($sp)
        lw $s3, 12($sp)
        caseFrom:
        caseF1:
        bne $s1, $a0, caseF2
        add $t1, $s5, $zero
        j caseTo
        caseF2:
        bne $s1, $v0, caseF3	
        add $t1, $s6, $zero
        j caseTo
        
        caseF3:
        bne $s1, $v1, caseTo
        add $t1, $s7, $zero


        caseTo:
        caseT1:
        bne $s2, $a0, caseT2
        add $t2, $s5, $zero
        j cont_moveValues
        
        caseT2:
        bne $s2, $v0, caseT3
        add $t2, $s6, $zero
        j cont_moveValues
        caseT3:
        bne $s2, $v1, cont_moveValues
        add $t2, $s7, $zero
        
        cont_moveValues:
        lw $t3, 0($t1)	#FROM
 	lw $t4, 0($t2)	#TO 
        
        beq $t4, $zero, next
 	addi $t2, $t2, 4
 	
 	next:
 	
 	add $t4, $t3, $zero
 	addi $t3, $zero, 0 
 	
 	sw $t3, 0($t1)	#FROM
 	sw $t4, 0($t2)	#TO 
 	
 	beq $t1, $a1, next2	
 	beq $t1, $a2, next2
 	beq $t1, $a3, next2
 	addi $t1, $t1, -4
 	
 	next2:
 	#beq $t2, $a1, caseRF1	
 	#beq $t2, $a2, caseRF1
 	#beq $t2, $a3, caseRF1
 	#addi $t2, $t2, 4
 	
 	caseRF1:
 	bne $s1, $a0, caseRF2
 	add $s5, $t1, $zero
 	j caseRT1
 	caseRF2:
 	bne $s1, $v0, caseRF3
 	add $s6, $t1, $zero
 	j caseRT1
 	caseRF3:
 	bne $s1, $v1, caseRT1
 	add $s7, $t1, $zero
 	
 	
 	
 	caseRT1:
 	bne $s2, $a0, caseRT2
 	add $s5, $t2, $zero
 	j nothing
 	caseRT2:
 	bne $s2, $v0, caseRT3
 	add $s6, $t2, $zero
 	j nothing
 	caseRT3:
 	
 	add $s7, $t2, $zero
 	
 	
 	nothing:
 	jr $ra
        
        
 end: