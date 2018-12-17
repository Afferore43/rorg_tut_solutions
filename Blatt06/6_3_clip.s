	.data
	
array:	.word 20,30,4,50,2,70,80,1
len:	.word 8

	.text
main:

	la $a0, array
	lw $a1, len
	
	jal clip
	
	addi $v0,$zero,10 #exit
	syscall
	

# function clip
# set all elements of int array that are smaller than 10 to 10
# no pseudoinstructions
clip:
    # parameters
    # $a0 = address of first element of array
    # $a1 = lenght of array

    # shift lenght by 2 for easier comparison to address
	sll $a1,$a1,2

    # $t0 to walk through array
	add $t0,$zero,$zero
	
for:
    # start for loop
    # if we walked through whole array exit for loop
	slt $t1,$t0,$a1
	beq $t1,$zero,end_for

    # get value of element a[i]
	add $t1,$a0,$t0
	lw $t2,0($t1)

    # check if element if smaller than 10
	slti $t2,$t2,10
	beq $t2,$zero,end_if
    # change element if it is
	addi $t2,$zero,10
	sw $t2,0($t1)
	
end_if:
    # add 4 to $t0 to
	addi $t0,$t0,4
	
	j for
end_for:

	jr $ra
