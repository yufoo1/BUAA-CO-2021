.data
	symbol: .space 28
	array: .space 28
	char_space: .asciiz " "
	char_enter: .asciiz "\n"
.text
main:
	li $v0, 5
	syscall
	move $s0, $v0 # record n
	li $a0, 0
	jal FullArray
	li $v0, 10
	syscall

FullArray:
	FullArray_if_1:
		slt $t0, $a0, $s0
		beq $t0, 1, FullArray_if_1_end
		li $t0, 0
		FullArray_for_1:
			beq $t0, $s0, FullArray_for_1_end
			sll $t1, $t0, 2
			lw $t1, array($t1)
			sw $a0, 0($sp)
			subi $sp, $sp, 4
			move $a0, $t1
			li $v0, 1
			syscall
			la $a0, char_space
			li $v0, 4
			syscall
			addi $sp, $sp, 4
			lw $a0, 0($sp)
			addi $t0, $t0, 1
			j FullArray_for_1
		FullArray_for_1_end:
		la $a0, char_enter
		li $v0, 4
		syscall
		jr $ra
	FullArray_if_1_end:
		li $t0, 0
		FullArray_for_2:
			beq $t0, $s0, FullArray_for_2_end
			FullArray_if_2:
				sll $t1, $t0, 2
				lw $t1, symbol($t1)
				bne $t1, 0, FullArray_if_2_end
				sll $t1, $a0, 2
				move $t2, $t0
				addi $t2, $t2, 1
				sw $t2, array($t1)
				sll $t1, $t0, 2
				li $t2, 1
				sw $t2, symbol($t1)
				sw $ra, 0($sp)
				subi $sp, $sp, 4
				sw $a0, 0($sp)
				subi $sp, $sp, 4
				sw $t0, 0($sp)
				subi $sp, $sp, 4
				sw $t1, 0($sp)
				subi $sp, $sp, 4
				addi $a0, $a0, 1
				jal FullArray
				addi $sp, $sp, 4
				lw $t1, 0($sp)
				addi $sp, $sp, 4
				lw $t0, 0($sp)
				addi $sp, $sp, 4
				lw $a0, 0($sp)
				addi $sp, $sp, 4
				lw $ra, 0($sp)
				sll $t1, $t0, 2
				li $t2, 0
				sw $t2, symbol($t1)
			FullArray_if_2_end:
			addi $t0, $t0, 1
			j FullArray_for_2
		FullArray_for_2_end:
	jr $ra
		
		
		
		
		
		
		
		
		