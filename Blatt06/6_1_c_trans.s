	.text
main:
# i is in $t0
	li $t0,0



# # #
# if(i < 0)
# # #
	bge $t0,0,after_if

# if content

after_if:



# # #
# if(i < 0) ... else
# # #
	bge $t0,0,else

# if content

	j end_if
else:

# else content

end_if:



# # #
# while(i < 0) 
# # #
while:
	bge $t0,0,end_while

# while content

	j while
end_while:



# # #
# for(int i = 0; i < 10; i++)
# # #
	li $t0,0
for:
	bge $t0,10,end_for
	
# for content
	addi $t0,$t0,1
	
	j for
end_for:



# # #
# int foo(int a, int b) { return a + b; }
# # #
foo:
# int a = $a0, int b = $a1
# foo content

# result in $v0
	add $v0, $a0, $a1
	jr $ra



# # #
# c = foo(0,1)
# # #
	li $a0,0
	li $a1,1
	jal foo
# result in $v0



# # #
# s register (in functions)
# # #
foo2:
	addi $sp, $sp, -8
	sw   $ra, 0($sp)
	sw   $a0, 4($sp)

# foo2 content

	lw   $ra, 0($sp)
	lw   $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra