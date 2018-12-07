	.data
array:	.word 0,1,1,3,5
len:	.word 5
	.text
main:
	la $a0,array
	lw $a1,len
	jal foo

	# print result
	move $a0,$v0
	li $v0,1		# System call code 1 (print_int)
	syscall
	
	li $v0, 10
	syscall


# function foo

# returns the index of the first element that already exists before that index in an array or 
# the lenght of the array if no repeating elements are found
foo:
	# parameters:
	# $a0 = address of first element of array
	# $a1 = lenght of array
	
	subi $t1,$a1,1
	
	# first counter
	li $t0,0
for_1:
	# count until n-1
	bge $t0,$t1,end_for_1
#content for_1 loop
	# second counter, starts at first_counter + 1
	addi $t2,$t0,1
for_2:
	# count until n
	bge $t2,$a1,end_for_2
#content for_2 loop

	# load array[$t0]
	sll $t3,$t0,2
	add $t3,$a0,$t3
	lw $t3,0($t3)
	
	# load array[$t2]
	sll $t4,$t2,2
	add $t4,$a0,$t4
	lw $t4,0($t4)
	
	# compare
	bne $t3,$t4,no_dice
	
	move $v0,$t2
	jr $ra
	
no_dice:
	
	addi $t2,$t2,1
#end content for_2 loop
	j for_2
end_for_2:

	addi $t0,$t0,1
	
#end content for_1 loop
	j for_1	
end_for_1:

	move $v0,$a1
	jr $ra