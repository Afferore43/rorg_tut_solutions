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
	

clip:
	sll $a1,$a1,2
	
	add $t0,$zero,$zero
	
for:
	slt $t1,$t0,$a1
	beq $t1,$zero,end_for
	
	add $t1,$a0,$t0
	lw $t2,0($t1)
	
	slti $t2,$t2,10
	beq $t2,$zero,end_if
	
	addi $t2,$zero,10
	sw $t2,0($t1)
	
end_if:
	addi $t0,$t0,4
	
	j for
end_for:

	jr $ra
