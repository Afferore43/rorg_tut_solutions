	.text

main:

	# blt $t0,$t1,label
	slt $t0,$t0,$t1
	bne $t0,$zero,label
	
	# ble $t0,$t1,label
	slt $t0,$t1,$t0
	beq $t0,$zero,label
	
	# bgt $t0,$t1,label 
	slt $t0,$t1,$t0
	bne $t0,$zero,label
	
	# bge $t0,$t1,label
	slt $t0,$t0,$t1
	beq $t0,$zero,label
	
	#li $t0,0xA756E1C7
	lui $t0,0xA756
	ori $t0,$t0,0xE1C7