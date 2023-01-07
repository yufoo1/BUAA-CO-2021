.data
array: .space 100
.text
li $v0, 5
syscall
move $s0, $v0 # record n
li $t0, 0
for_1:
	beq $t0, $s0, for_1_end
	li $v0, 12
	syscall
	sb $v0, array($t0)
	addi $t0, $t0, 1
	j for_1
for_1_end:
li $t0, 0
move $t1, $s0
subi $t1, $t1, 1
for_2:
	slt $t2, $t0, $t1
	bne $t2, 1, for_2_end
	if_1:
		lb $t2, array($t0)
		lb $t3, array($t1)
		beq $t2, $t3, if_1_end
		li $a0, 0
		li $v0, 1
		syscall
		li $v0, 10
		syscall
	if_1_end:
	addi $t0, $t0, 1
	subi $t1, $t1, 1
	j for_2
for_2_end:
li $a0, 1
li $v0, 1
syscall
li $v0, 10
syscall