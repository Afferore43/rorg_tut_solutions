	.data

msg:	.asciiz "Enter number: "

	.text
main:
	la $a0,msg
	jal print_str
	jal input_int
	move $a0, $v0
	
	jal fib
	move $a0,$v0
	jal print_int
	
	li $v0, 10   		# System call code 10 (exit).
	syscall
 
input_int:
	li $v0,  5
	syscall
	jr $ra

print_int:
	li $v0,1
	syscall
	jr $ra

print_str:
	li $v0,4
	syscall
	jr $ra

fib:
	# save registers on stack
	addi $sp, $sp, -12
	sw   $ra, 0($sp)
	sw   $a0, 4($sp)
	sw   $s0, 8($sp)
	
	bge $a0,2,else
	move $v0,$a0
	j exit_fib
	
else:
	sub $a0,$a0,1
	jal fib
	move $s0,$v0
	
	sub $a0,$a0,1
	jal fib
	
	add $v0,$v0,$s0
	j exit_fib
	
exit_fib:
	# load registers from stack
	lw   $ra, 0($sp)
	lw   $a0, 4($sp)
	lw   $s0, 8($sp)
	addi $sp, $sp, 12
	jr $ra
