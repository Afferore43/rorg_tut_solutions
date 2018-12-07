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

print_int:
	li $v0,1
	syscall
	jr $ra


minimum:
	sll $a1,$a1,2
	
	# counter
	add $t0,$zero,$zero
	# min
	lw $v0,0($a0)
for:
	slt $t1,$t0,$a1
	beq $t1,$zero,end_for
	
	add $t1,$a0,$t0
	lw $t2,0($t1)
	
	slt $t1,$t2,$v0
	beq $t1,$zero,end_if
	
	move $v0,$t2
	
end_if:
	addi $t0,$t0,4
	
	j for
end_for:

	jr $ra
