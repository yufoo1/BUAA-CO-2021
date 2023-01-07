.data
	number: .space 1020
.text
main:
	li $v0, 5
	syscall
	addi $v0, $v0, 1
	move $s0, $v0 #record n+1
	special:
	bne $s0, 1, special_end
	li $v0, 1
	li $a0, 1
	syscall
	li $v0, 10
	syscall
	special_end: 
	li $t0, 1
	sw $t0, 0($0)
	li $t0, 2
	li $s2, 10000
	main_for_1:
		beq $t0, $s0, main_for_1_end
		li $s1, 0
		li $t1, 0
		main_for_2:
			beq $t0, $t1, main_for_2_end
			sll $t2, $t1, 2
			lw $t5, number($t2)
			mult $t5, $t0
			mflo $t5
			add $t5, $t5, $s1
			div $t5, $s2
			mflo $s1
			mfhi $t3
			sw $t3, number($t2)
			addi $t1, $t1, 1
			j main_for_2
		main_for_2_end:
		addi $t0, $t0, 1
		j main_for_1
	main_for_1_end:
	li $t0, 254
	li $t1, 0
	main_for_3:
		slt $t2, $t0, $0
		beq $t2, 1, main_for_3_end
		main_if_1:
			sll $t2, $t0, 2
			lw $t2, number($t2)
			bne $t1, 0, main_if_1_else
			bne $t2, 0, main_if_1_else
			j main_if_1_end
		main_if_1_else:
			main_if_2:
				bne $t1, 0, main_if_2_else
				move $a0, $t2
				li $v0, 1
				syscall
				j main_if_2_end
			main_if_2_else:
				li $v0, 1
				li $a0, 0
				main_if_3:
					slti $t3, $t2, 1000
					bne $t3, 1, main_if_3_end
					li $a0, 0
					li $v0, 1
					syscall
				main_if_3_end:
				main_if_4:
					slti $t3, $t2, 100
					bne $t3, 1, main_if_4_end
					li $a0, 0
					li $v0, 1
					syscall
				main_if_4_end:
				main_if_5:
					slti $t3, $t2, 10
					bne $t3, 1, main_if_5_end
					li $a0, 0
					li $v0, 1
					syscall
				main_if_5_end:
				move $a0, $t2
				li $v0, 1
				syscall
			main_if_2_end:
				li $t1, 1
		main_if_1_end:
		subi $t0, $t0, 1
		j main_for_3
	main_for_3_end:
	
	li $v0, 10
	syscall
