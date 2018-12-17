	.data
	
array:	.word 20,30,40,50,20,70,80,100
len:	.word 8

	.text
main:

	la $a0, array
	lw $a1, len
	
	jal minimum
	move $a0,$v0
	jal print_int
	
	addi $v0,$zero,10 #exit
	syscall

# helper function
print_int:
	li $v0,1
	syscall
	jr $ra

# function min
# get smallest value in int array
# no pseudoinstructions
minimum:
    # parameters
    # $a0 = address of first element in array
    # $a1 = lenght of array

    # shift lenght by 2 for easier comparison to address
	sll $a1,$a1,2
	
	# counter to walk through array
	add $t0,$zero,$zero

	# min, set to value of first element
	lw $v0,0($a0)

    # walk through array
for:
    # check if we should exit for loop
	slt $t1,$t0,$a1
	beq $t1,$zero,end_for

    # load element a[i]
	add $t1,$a0,$t0
	lw $t2,0($t1)

    # if new element is smaller than min before, set as new min
	slt $t1,$t2,$v0
	beq $t1,$zero,end_if
	
	move $v0,$t2
	
end_if:
    # add 4 for next element in array
	addi $t0,$t0,4
	
	j for
end_for:

	jr $ra
