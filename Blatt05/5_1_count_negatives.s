	.data
	
array:	.word -1,-2,-3,-4,0,1,3,-7,-8,0,-9
len:	.word 11

	.text
main:
	la $a0, array
	lw $a1, len
	
	jal count_negatives
	
	# print result
	move $a0,$v0
	li $v0,1		# System call code 1 (print_int)
	syscall
	
	li $v0, 10   		# System call code 10 (exit).
 	syscall
	
count_negatives: 
	# parameters
	# $a0 = address of first element in array
	# $a1 = lenght of array
	
	sll $a1,$a1,2 #shift lenght of array by 2 <=> multiply by 4 (for easy comparison with index, where 1 element == 4 bytes)
	
	li $t0,0 # index counter

	li $v0,0 # counting all negative numbers
for:
 	bge $t0,$a1,end_for
	
	#for loop content
	
	add $t1,$a0,$t0 # calculate address of first element + index
	lw $t2, 0($t1) # load element at index
	
	slti $t2,$t2,0 # if element is negative, increase counter
	add $v0,$v0,$t2
	
	addi $t0,$t0,4 # increase array index by 4 (next element)
	
	j for
	
end_for:
	
	# returns count of negative numbers in $v0
	jr $ra
	
# end count_negatives