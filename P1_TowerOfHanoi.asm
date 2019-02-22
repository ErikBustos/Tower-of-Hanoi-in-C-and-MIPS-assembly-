# DEVELOPERS:
#	Erik Bustos Montes de oca
# 	Bernardo Elizondo Hernández
.data
	Tower1: .word 0x0 	# will be stored in s5
	Tower2: .word 0x0 	# will be stored in s6
	Tower3: .word 0x0 	# will be stored in s7
	
.text 

	main:
	 	addi $s0, $zero, 3	# numberOfDiscs
	 	add $t0, $zero, $s0 	# n=numberOfDiscs

		 #load address of Tower1 in s5
 		addi $s5, $zero, 0x1001
 		sll $s5, $s5, 16	
 		
 		#load address of Tower2 in s6
 		addi $s6, $zero, 0x1001
 		sll $s6, $s6, 16
 		addi $s6, $s6, 0x0020
 		
   		#load address of Tower3 in s7
 		addi $s7, $zero, 0x1001
 		sll $s7, $s7, 16
 		addi $s7, $s7, 0x0040
 				
		jal createFirstTower		
 
		 #moveDisc(int n, t1,t3,t2)		 
	 	add $s4, $zero, $s0	# n for the move disc subroutine
		add $s1, $s5, $zero #s1= T1
		add $s2, $s7, $zero #s2= T3
		add $s3, $s6, $zero #S3= T2
		jal moveDisc
		
		j end
	 	
	 	
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
	 	jr $ra
	
 #--------------------------------------------------------------------------------------------	
 # 	void moveDisc(int n, int * from, int * to, int * intermediate)
 #	n: 		S4   = numberOfDiscs
 #	from:		S1
 #	to: 		s2
 #	intermediate:	s3
 
 	moveDisc:
 	
 		bne $s4, 1, else_ifmove	# if(n !=1) jump to else, if n==1 then do the next lines 		
 		#jal moveValues
 		jal end
 	else_ifmove:
 		
 		#moveDisc(n-1,from,intermediate,to); 
 		 addi $s4, $s4, -1 	# n-1		
 		 add $t0 , $s3, $zero # temp= intermediate;
 		 add $s3, $s2, $zero # intermediate=to;
 		 add $s2, $t0, $zero # to=temp;
 		 jal moveDisc
 		 
 		 #jal moveValues
 		 
 		 #moveDisc(n-1,intermediate,to,from); 
 		 addi $s4, $s4, -1 	# n-1	
 		 add $t0 , $s3, $zero # temp= intermediate;
 		 add $s3, $s1, $zero # intermediate=from;
 		 add $s1, $t0, $zero # from=temp;
 		 
 		 jal moveDisc
 	
 	#end MoveDisc	 
		
 
#Function that moves the pointers of the from and to towers to the last position to be able to move the disc
# void moveValues(int * from, int * to)		
#from: s1
#to: s2	
 	moveValues:
 		addi $a1,$zero,1  #int i=1;
 		
 		for1_mv:
 		
 			beq $t1, $s0,  endfor1_mv 
 			
 		j for1_mv:
 				
 		
	 end:
	 	 
