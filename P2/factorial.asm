.data
	ans: .space 5000
.text
main:
	li $v0, 5
	syscall
	addi $v0, $v0, 1
	move $s0, $v0 # s0 record n+1
	li $s1, 1 # s1 record len
	sw $s1, ans($0)
	li $t0, 2
	main_for_1:
		beq $t0, $s0, main_for_1_end
		li $t1, 0
		main_for_2:
			beq $t1, $s1, main_for_2_end
			sll $t2, $t1, 2
			lw $t3, ans($t2)
			mult $t3, $t0
			mflo $t3
			sw $t3, ans($t2)
			addi $t1, $t1, 1
			j main_for_2
		main_for_2_end:
		li $t1, 0
		main_for_3:
			beq $t1, $s1, main_for_3_end
			sll $t2, $t1, 2
			lw $t2, ans($t2)
			li $t3, 10
			div $t2, $t3
			mflo $t2
			add $t3, $t1, 1
			sll $t3, $t3, 2
			lw $t4, ans($t3)
			add $t4, $t4, $t2
			sw $t4, ans($t3)
			mfhi $t2
			sll $t3, $t1, 2
			sw $t2, ans($t3)
			addi $t1, $t1, 1
			j main_for_3
		main_for_3_end:
		main_while_1:
			sll $t1, $s1, 2
			lw $t1, ans($t1)
			slt $t1, $0, $t1
			bne $t1, 1, main_while_1_end
			addi $s1, $s1, 1
			subi $t1, $s1, 1
			sll $t1, $t1, 2
			lw $t1, ans($t1)
			li $t2, 10
			div $t1, $t2
			mflo $t1
			sll $t2, $s1, 2
			sw $t1, ans($t2)
			mfhi $t1
			subi $t2, $s1, 1
			sll $t2, $t2, 2
			sw $t1, ans($t2)
			j main_while_1
		main_while_1_end:
		addi $t0, $t0, 1
		j main_for_1
	main_for_1_end:
	move $t0, $s1
	subi $t0, $t0, 1
	main_for_4:
		slti $t1, $t0, 0
		beq $t1, 1, main_for_4_end
		sll $t1, $t0, 2
		lw $a0, ans($t1)
		li $v0, 1
		syscall
		subi $t0, $t0, 1
		j main_for_4
	main_for_4_end:
	li $v0, 10
	syscall
	
	
