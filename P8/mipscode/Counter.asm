.text
	li $t5, 1025
	mtc0 $t5, $12
	lw $t0, 0x7f50($0)
	sw $t0, 0x7f44($0)
	li $t1, 25000000
	sw $t1, 0x7f04($0)
	li $t2, 11
	sw $t2, 0x7f00($0)
Loop:
	lw $t3, 0x7f50($0)
	beq $t3, $t0, Loop
	nop
	sw $t3, 0x7f44($0)
	j Loop
	addu $t0, $0, $t3

.ktext 0x4180
	lw $t4, 0x7f44($0)
	beq $t4, $0, end
	nop
	addiu $t4, $t4, -1
end:
	sw $t4, 0x7f44($0)
	eret
	nop
