# DEVELOPERS:
#	Erik Bustos Montes de oca
# 	Bernardo Elizondo Hernández
.data
	Tower1: .word 0x0
	Tower2: .word 0x0
	Tower3: .word 0x0
	
.text 

	main:
	 	addi $s0, $zero, 3 	# numberOfDiscs
	 	add $t0, $zero, $s0 	# n=numberOfDiscs
	 
	 jal createFirstTower
	
	j end
	 	
	 	
 #--------------------------------------------------------------------------------------------	
 #	Subroutine that creates and fill the first tower depending of the numer of Discs with a loop.	 
	 createFirstTower:

	 	
	 	la $t1, Tower1 		# load address of Tower1
	 	
	 for:
	 		beqz $t0, endfor 	# if n==0 then break
	 		sw $t0, ($t1)       	# store in Tower1 the T0 value (n)
	 		
	 		addi $t0, $t0, -1 	# n--;
	 		addi $t1, $t1, 4	#add 4 bits to the direction
	 		j for
	 		
	 endfor:
	  #end of subroutine
	 	jr $ra
	
 #--------------------------------------------------------------------------------------------	
 # 	void moveDisc(int n, int * from, int * to, int * intermediate)
 #	n: 	S0   = numberOfDiscs
 #	from:	S1
 #	to: 	s2
 #	intermediate:	s3
 	moveDisc:
 		add $t0, $zero, $zero 	# i=0
 		bne $s0, 1, else_ifmove	# if(n!=1) jump to else, if n==1 then do the next lines
 		
 		
 	else_ifmove:
 	
 		
 		
 		
	 end:
	 	 