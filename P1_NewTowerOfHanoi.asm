# DEVELOPERS:
#	Erik Bustos Montes de oca
# 	Bernardo Elizondo Hernández

.data
	Tower1: .word 0x0 	# will be stored in s5
	Tower2: .word 0x0 	# will be stored in s6
	Tower3: .word 0x0 	# will be stored in s7
	
.text 

	main:
		addi $s0, $zero, 8	# numberOfDiscs
	 	add $t0, $zero, $s0 	# n=numberOfDiscs

		 #load address of Tower1 in s5
 		addi $s5, $zero, 0x1001
 		sll $s5, $s5, 16	
 		
 		#load address of Tower2 in s6
 		addi $s6, $s5, 0x0020
 		
   		#load address of Tower3 in s7
 		addi $s7, $s5, 0x0040
 		
 		jal createFirstTower	#after this we have in the pointer s5 the top of tower 1	
 		 		
 		add $s4, $s0 ,$zero  # n for the move disc subroutine
 		add $s1, $s5, $zero #from  =t1
 		add $s2, $s7, $zero #to = t3
 		add $s3, $s6, $zero #intermediate = t2
 		jal moveDisc #moveDisc(numberOfDisc, t1, t3, t2)
 		
 		j endOfProgram
 
  #--------------------------------------------------------------------------------------------	
 # 	void moveDisc(int n, int * from, int * to, int * intermediate)
 #	n: 		S4   = numberOfDiscs
 #	from:		S1
 #	to: 		S2
 #	intermediate:	s3				
 	moveDisc:
 		addi $sp, $sp, -4 # stack
 		sw $ra, ($sp)
 		
 		bne $s4, 1, else_ifmove	# if(n !=1) jump to else, if n==1 then do the next line		
 
 		#pop
 		addi $s1, $s1, -4 #move the pointer one position below
 		lw $t0,($s1) #get the value of the pointer
 		sw $zero,($s1) #write zero to erase
 		
 		#push
 		sw $t0,($s2) #push value at top of the "to" tower	 	
 		addi $s2, $s2, 4 #increment the pointer to the next value
 		
 		addi $s4,$s4,1 #n++
 		lw $ra, ($sp) #load return address from stack
 		addi $sp $sp, 4 
 		
 		jr $ra 
#----------------------------------end of case if n=1--------------------------------	
 	else_ifmove:
 		addi $s4, $s4, -1 #n-1
 		#swap
 		add $t0, $s2, $zero # temp=to
 		add $s2, $s3, $zero # to= intermediate
 		add $s3, $t0, $zero # intermediate = temp
 		
 		jal moveDisc #moveDisc(n-1,from, intermediate, to);
 		
 		add $t0, $s2, $zero # temp= to
 		add $s2, $s3, $zero # to= intermediate
 		add $s3, $t0, $zero # intermediate= temp
 		
 		 #pop
 		addi $s1, $s1, -4 #move the pointer one position below
 		lw $t0,($s1) #get the value of the pointer
 		sw $zero,($s1) #write zero to erase
 		
 		#push
 		sw $t0,($s2) #push value at top of the "to" tower	 	
 		addi $s2, $s2, 4 #increment the pointer to the next value
 		
 		addi $s4, $s4, -1 #n-1
 		add $t0, $s1, $zero # temp= from
 		add $s1, $s3, $zero # from= intermediate
 		add $s3, $t0, $zero # intermediate = temp
 		
 		jal moveDisc #moveDisc(n-1,intermediate, to, from);
 		
 		add $t0, $s1, $zero #temp= to
 		add $s1, $s3, $zero #to=intermediate
 		add $s3, $t0, $zero #intermediate= temp
 				 		
 		addi $s4, $s4, 1 #n++
 		lw $ra, ($sp) #load return address from stack
 		addi $sp $sp, 4  		
 		jr $ra 
 				 			 	
 #--------------------------------------------------------------------------------------------	
 #	Subroutine that creates and fill the first tower depending of the numer of Discs with a loop.	 
	 createFirstTower:

	 	add $t1, $zero, $s5  #load address of Tower1
	
	 	
	 for:
	 		beq $t0, $zero, endfor  #t0=n
	 		sw $t0, ($s5)       	# store in Tower1 the T0 value (n)
	 		
	 		addi $t0, $t0, -1 	# n--;
	 		addi $s5, $s5, 4	#add 4 bits to the direction
	 		j for
	 		
	 endfor:
	  #end of subroutine
	 	jr $ra
	 	
#-----------------------------------------------------------------------------------------------------	
 	
 	
 	endOfProgram: