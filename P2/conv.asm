.data
	f: .space 484
	h: .space 484
	char_space: .asciiz " "
	char_enter: .asciiz "\n"
.text
main:
	li $v0, 5
	syscall
	move $s0, $v0 # s0 record m1
	li $v0, 5
	syscall
	move $s1, $v0 # s1 record n1
	li $v0, 5
	syscall
	move $s2, $v0 # s2 record m2
	li $v0, 5
	syscall
	move $s3, $v0 # s3 record n2
	sub $s4, $s0, $s2 # record m1-m2+1
	addi $s4, $s4, 1
	sub $s5, $s1, $s3 
	addi $s5, $s5, 1 # record n1-n2+1
	li $t0, 0
	main_for_1:
		beq $t0, $s0, main_for_1_end
		li $t1, 0
		main_for_2:
			beq $t1, $s1, main_for_2_end
			move $a0, $s1
			move $a1, $t0
			move $a2, $t1
			jal getIndex
			move $t2, $v0
			li $v0, 5
			syscall
			sw $v0, f($t2)
			addi $t1, $t1, 1
			j main_for_2
		main_for_2_end:	
		addi $t0, $t0, 1
		j main_for_1
	main_for_1_end:
	
	li $t0, 0
	main_for_3:
		beq $t0, $s2, main_for_3_end
		li $t1, 0
		main_for_4:
			beq $t1, $s3, main_for_4_end
			move $a0, $s3
			move $a1, $t0
			move $a2, $t1
			jal getIndex
			move $t2, $v0
			li $v0, 5
			syscall
			sw $v0, h($t2)
			addi $t1, $t1, 1
			j main_for_4
		main_for_4_end:	
		addi $t0, $t0, 1
		j main_for_3
	main_for_3_end:
	li $t0, 0
	main_for_5:
		beq $t0, $s4, main_for_5_end
		li $t1, 0
		main_for_6:
			beq $t1, $s5, main_for_6_end
			li $s6, 0
			li $t2, 0
			main_for_7:
				beq $t2, $s1, main_for_7_end
				li $t3, 0
				main_for_8:
					beq $t3, $s3, main_for_8_end
					move $a0, $s1
					add $a1, $t0, $t2
					add $a2, $t1, $t3
					jal getIndex
					lw $t4, f($v0)
					move $a0, $s3
					move $a1, $t2
					move $a2, $t3
					jal getIndex
					lw $t5, h($v0)
					mult $t4, $t5
					mflo $t4
					add $s6, $s6, $t4
					addi $t3, $t3, 1
				j main_for_8
				main_for_8_end:
				
				addi $t2, $t2, 1
				j main_for_7
			main_for_7_end:
			li $v0, 1
			move $a0, $s6
			syscall
			la $a0, char_space
			li $v0, 4
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