	.data
string:	.asciiz "c-code ist der coolste code."
letter: .byte 'c'
	.text
	
main:
	la $a0,string
	lb $a1,letter
	
	jal squeeze
	
	li $v0,4 #print string
	la $a0,string
	syscall

	li $v0,10 #exit
	syscall

# removes all instances of a certain letter from a string
squeeze:
	# parameters:
	# $a0 = address of first character of string
	# $a1 = letter to remove
	
	move $t0,$a0
	move $t1,$a0
	
	lb $t2,0($t0)
	
for_loop:
	beq $t2,0,end_for
	
	beq $t2,$a1,same_letter
	
	# not the same letter:
	sb $t2,0($t1)
	
	addi $t1,$t1,1
same_letter:

	addi $t0,$t0,1
	lb $t2,0($t0)
	j for_loop
end_for:
	sb $zero,0($t1)
	
	jr $ra
