	.data

# this string contains 4 numbers
string:	.asciiz "123hell0 w0rld56"

	.text
	la $a0,string
	
	#lb $a0,($a0)
	#jal is_digit
	jal number_of_numbers
	
	move $a0,$v0
	
	li $v0,1
	syscall
	
	
	li $v0,10 #exit
	syscall
	
# check if character is a digit

# params:
# a0 = character
# returns
# 1 if a0 is a digit, otherwise 0
is_digit:
	# jump to not_dig if, $a0 smaller than '0'
	li $t0,'0'
	bltu $a0,$t0,not_dig # char is unsigned
	
	# jump to not_dig if, '9' smaller than $a0
	li $t0,'9'
	bltu $t0,$a0,not_dig
	
	# set return reg to 1 and return
	li $v0,1
	jr $ra
	
not_dig:
	# set return reg to 0 and return
	li $v0,0
	jr $ra


# count number of numbers in string

# params:
# a0 = address of first character of string

# returns
# number of numbers in string
number_of_numbers:
	# save registers on stack
	addi $sp, $sp, -24
	sw   $ra, 0($sp)
	sw   $a0, 4($sp)
	sw   $s0, 8($sp)
	sw   $s1, 12($sp)
	sw   $s2, 16($sp)
	sw   $s3, 20($sp)
	
	move $s0,$a0
	li $s1,0 # i
	li $s2,0 # lastCharIsDigit
	li $s3,0 # count
	
while:
	# add adress of first char and i
	# to get string[i]
	add $t0,$s0,$s1
	# load value at string[i]
	lb $a0,($t0)
	# if string[i] == 0, exit while loop
	beq $a0,0,end_while
	
	jal is_digit
	
	# add lastCharIsDigit and return value from is_digit
	add $t0,$v0,$s2
	# if that equals 1, we found a new number, otherwise jump forward
	# if lastCharIsDigit != 0, we set it to 2, so $t0, would be 3 if both true
	bne $t0,1,no_new_number
	# add 1 to number counter
	add $s3,$s3,1
	# set lastCharIsDigit to 2
	li $s2,2
	
no_new_number:
	# add 1 to i, => next char
	add $s1,$s1,1
	
	# get value of string[i] again
	add $t0,$s0,$s1
	lb $a0,($t0)
	
	jal is_digit
	
	# if next char is not a digit, set lastCharIsDigit to 0
	bgt $v0,0,not_a_digit
	li $s2,0
not_a_digit:
	
	j while
	
end_while:
	# move counter to return register
	move $v0,$s3
	
	# load registers from stack
	lw   $ra, 0($sp)
	lw   $a0, 4($sp)
	lw   $s0, 8($sp)
	lw   $s1, 12($sp)
	lw   $s2, 16($sp)
	lw   $s3, 20($sp)
	addi $sp, $sp, 24
	jr $ra
