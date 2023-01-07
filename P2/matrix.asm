.data
	a: .space 324
	b: .space 324
	char_space: .asciiz " " 
	char_enter: .asciiz "\n"
.text

main:
	li $v0, 5
	syscall
	move $s0, $v0 #s0 record n
	li $t0, 0
	main_for_1:
		beq $t0, $s0, main_for_1_end
		li $t1, 0
		main_for_2:
			beq $t1, $s0, main_for_2_end
			move $a0, $s0
			move $a1, $t0
			move $a2, $t1
			jal getIndex
			move $t2, $v0
			li $v0, 5
			syscall
			sw $v0, a($t2)
			addi $t1, $t1, 1
			j main_for_2
		main_for_2_end:
		addi $t0, $t0, 1
		j main_for_1
	main_for_1_end:
	li $t0, 0
	main_for_3:
		beq $t0, $s0, main_for_3_end
		li $t1, 0
		main_for_4:
			beq $t1, $s0, main_for_4_end
			move $a0, $s0
			move $a1, $t0
			move $a2, $t1
			jal getIndex
			move $t2, $v0
			li $v0, 5
			syscall
			sw $v0, b($t2)
			addi $t1, $t1, 1
			j main_for_4
		main_for_4_end:
		addi $t0, $t0, 1
		j main_for_3
	main_for_3_end:
	li $t0, 0
	main_for_5:
		beq $t0, $s0, main_for_5_end
		li $t1, 0
		main_for_6:
			beq $t1, $s0, main_for_6_end
			li $t2, 0
			li $s1, 0
			main_for_7:
				beq $t2, $s0, main_for_7_end
				move $a0, $s0
				move $a1, $t0
				move $a2, $t2
				jal getIndex
				lw $s2, a($v0)
				move $a0, $s0
				move $a1, $t2
				move $a2, $t1
				jal getIndex
				lw $s3, b($v0)
				mult $s2, $s3
				mflo $s2
				add $s1, $s1, $s2
				addi $t2, $t2, 1
				j main_for_7
			main_for_7_end:
			li $v0, 1
			move $a0, $s1
			syscall
			li $v0, 4
			la $a0, char_space
			syscall
			addi $t1, $t1, 1
			j main_for_6
		main_for_6_end:
		la $a0, char_enter
		li $v0, 4
		syscall
		addi $t0, $t0, 1
		j main_for_5
	main_for_5_end:
	
	
	li $v0, 10
	syscall
	
	
getIndex:
	mult $a0, $a1
	mflo $v0
	add $v0, $v0, $a2
	sll $v0, $v0, 2
	jr $ra
	
