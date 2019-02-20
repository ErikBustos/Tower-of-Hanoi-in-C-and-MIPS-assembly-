# DEVELOPERS:
#	Erik Bustos Montes de oca
# 	Bernardo Elizondo Hernández
.data
	Tower1: .word 0x0
	
.text 

	main:
	 	addi $s0, $zero, 3 	# numberOfDiscs
	 	add $t0, $zero, $s0 	# n=numberOfDiscs
	 
	 	#this section of code create the tower with its values
	 	
	 	la $t1, Tower1 		# load address of Tower1
	 	
	 for:
	 		beqz $t0, endfor 	# if n==0 then break
	 		sw $t0, ($t1)       	# store in Tower1 the T0 value (n)
	 		
	 		addi $t0, $t0, -1 	# n--;
	 		addi $t1, $t1, 4
	 		j for
	 		
	 endfor:
	 	
	 	
	 	