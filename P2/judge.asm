.data
	string: .space 21
.text
	li $v0, 5
	syscall
	move $s0, $v0
	li $t0, 0
	for_2:
		beq $t0, $s0, for_2_end
		li $v0, 12
		syscall
		sb $v0, string($t0)
		addi $t0, $t0, 1
		j for_2
	for_2_end:
	move $a1, $s0
	# t0 record i
	li $t0, 0
	# t1 record j
	move $t1, $s0
	subi $t1, $t1, 1
	for_1:
		slt $t2, $t0, $t1
		beq $t2, 0, for_1_end
		if_1:
			lb $t2, string($t0)
			lb $t3, string($t1)
			beq $t2, $t3, if_1_end
			li $a0, 0
			li $v0, 1
			syscall
			li $v0, 10
			syscall
		if_1_end:
		addi $t0, $t0, 1
		subi $t1, $t1, 1
		j for_1
	for_1_end:
	li $a0, 1
	li $v0, 1
	syscall
	li $v0, 10
	syscall