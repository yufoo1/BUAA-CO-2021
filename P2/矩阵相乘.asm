.data
	matrix_a: .space 400
	matrix_b: .space 400
	char_space: .asciiz " "
	char_enter: .asciiz "\n"

.text
main:
	li $v0, 5
	syscall
	# $s0 record n
	move $s0, $v0
	la $s1, char_space
	la $s2, char_enter
	li $t2, 0 # i
	for_1:
		beq $t2, $s0, for_1_end
		li $t3, 0 # j
		for_2:
			beq $t3, $s0, for_2_end
			move $a0, $s0
			move $a1, $t2
			move $a2, $t3
			jal getIndex
			sll $v0, $v0, 2
			move $t4, $v0
			li $v0, 5
			syscall
			sw $v0, matrix_a($t4)
			addi $t3, $t3, 1
			j for_2
		for_2_end:
		addi $t2, $t2, 1
		j for_1
	for_1_end:
	li $t2, 0
	for_3:
		beq $t2, $s0, for_3_end
		li $t3 0
		for_4:
			beq $t3, $s0, for_4_end
			move $a0, $s0
			move $a1, $t2
			move $a2, $t3
			jal getIndex
			sll $v0, $v0, 2
			move $t4, $v0
			li $v0, 5
			syscall
			sw $v0, matrix_b($t4)
			addi $t3, $t3, 1
			j for_4
		for_4_end:
		addi $t2, $t2, 1
		j for_3
	for_3_end:
	li $t2, 0
	for_5:
		beq $t2, $s0, for_5_end
		li $t3, 0
		for_6:
			beq $t3, $s0, for_6_end
			li $t4, 0
			li $t5, 0
			for_7:
				beq $t4, $s0, for_7_end
				move $a0, $s0
				move $a1, $t2
				move $a2, $t4
				jal getIndex
				sll $v0, $v0, 2
				lw $t6, matrix_a($v0)
				move $a0, $s0
				move $a1, $t4
				move $a2, $t3
				jal getIndex
				sll $v0, $v0, 2
				lw $t7, matrix_b($v0)
				mult $t6, $t7
				mflo $t6
				add $t5, $t5, $t6
				
				addi $t4, $t4, 1
				j for_7
			for_7_end:
			move $a0, $t5
			li $v0, 1
			syscall
			la $a0, char_space
			li $v0, 4
			syscall
			addi $t3, $t3, 1
			j for_6
		for_6_end:
		la $a0, char_enter
		li $v0, 4
		syscall
		addi $t2, $t2, 1
		j for_5
	for_5_end:
	li $v0, 10
	syscall
	
	
getIndex:
	mult $a0, $a1
	mflo $v0
	add $v0, $v0, $a2
	jr $ra
	
	
	
	
	
	
	
