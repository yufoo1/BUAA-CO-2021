.data
	matrix: .space 196
	flag: .space 196
.text
main:
	li $v0, 5
	syscall
	move $s0, $v0 # s0 record n
	li $v0, 5
	syscall
	move $s1, $v0 # s1 record m
	li $t0, 0
	main_for_1:
		beq	$t0, $s0, main_for_1_end
		li $t1, 0
		main_for_2:
			beq $t1, $s1, main_for_2_end
			move $a0, $s1
			move $a1, $t0
			move $a2, $t1
			jal getIndex
			move $t3, $v0 # record index
			li $v0, 5
			syscall
			sw $v0, matrix($t3)
			addi $t1, $t1, 1
			j main_for_2
		main_for_2_end:
		addi $t0, $t0, 1
		j main_for_1
	main_for_1_end:
	li $v0, 5
	syscall
	subi $v0, $v0, 1
	move $s2, $v0 # record start_point_x
	li $v0, 5
	syscall
	subi $v0, $v0, 1
	move $s3, $v0 # record start_point_y
	li $v0, 5
	syscall
	subi $v0, $v0, 1
	move $s4, $v0 # record end_point_x
	li $v0, 5
	syscall
	subi $v0, $v0, 1
	move $s5, $v0 # record end_point_y
	li $s6, 0 # record cnt
	move $a0, $s1
	move $a1, $s2
	move $a2, $s3
	jal getIndex
	li $t0, 1
	sw $t0, flag($v0)
	move $a0, $s2
	move $a1, $s3
	jal dfs
	li $v0, 1
	move $a0, $s6
	syscall
	li $v0, 10
	syscall
	
	
	
getIndex:
	mult $a0, $a1
	mflo $v0
	add $v0, $v0, $a2
	sll $v0, $v0, 2
	jr $ra
	
	
dfs:
	dfs_if_1:
		bne $a0, $s4, dfs_if_1_else
		bne $a1, $s5, dfs_if_1_else
		addi $s6, $s6, 1
		j dfs_if_1_end
	dfs_if_1_else:
		dfs_if_2:
			slti $t0, $a0, 1
			beq $t0, 1, dfs_if_2_end
			subi $t0, $a0, 1
			sw $ra, 0($sp)
			subi $sp, $sp, 4
			sw $a0, 0($sp)
			subi $sp, $sp, 4
			sw $a1, 0($sp)
			subi $sp, $sp, 4
			move $a0, $s1
			move $a2, $a1
			move $a1, $t0
			jal getIndex
			addi $sp, $sp, 4
			lw $a1, 0($sp)
			addi $sp, $sp, 4
			lw $a0, 0($sp)
			addi $sp, $sp, 4
			lw $ra, 0($sp)
			lw $t0, flag($v0)
			bne $t0, 0, dfs_if_2_end
			lw $t0, matrix($v0)
			bne $t0, 0, dfs_if_2_end
			li $t0, 1
			sw $t0, flag($v0)
			sw $ra 0($sp)
			subi $sp, $sp, 4
			sw $a0, 0($sp)
			subi $sp, $sp, 4
			sw $v0, 0($sp)
			subi $sp, $sp, 4
			subi $a0, $a0, 1
			jal dfs
			addi $sp, $sp, 4
			lw $v0, 0($sp)
			addi $sp, $sp, 4
			lw $a0, ($sp)
			addi $sp, $sp, 4
			lw $ra, 0($sp)
			li $t0, 0
			sw $t0, flag($v0)
		dfs_if_2_end:
		dfs_if_3:
			slti $t0, $a1, 1
			beq $t0, 1, dfs_if_3_end
			subi $t0, $a1, 1
			sw $ra, 0($sp)
			subi $sp, $sp, 4
			sw $a0, 0($sp)
			subi $sp, $sp, 4
			sw $a1, 0($sp)
			subi $sp, $sp, 4
			move $a1, $a0
			move $a0, $s1
			move $a2, $t0
			jal getIndex
			addi $sp, $sp, 4
			lw $a1, 0($sp)
			addi $sp, $sp, 4
			lw $a0, 0($sp)
			addi $sp, $sp, 4
			lw $ra, 0($sp)
			lw $t0, flag($v0)
			bne $t0, 0, dfs_if_3_end
			lw $t0, matrix($v0)
			bne $t0, 0, dfs_if_3_end
			li $t0, 1
			sw $t0, flag($v0)
			sw $ra 0($sp)
			subi $sp, $sp, 4
			sw $a1, 0($sp)
			subi $sp, $sp, 4
			sw $v0, 0($sp)
			subi $sp, $sp, 4
			subi $a1, $a1, 1
			jal dfs
			addi $sp, $sp, 4
			lw $v0, 0($sp)
			addi $sp, $sp, 4
			lw $a1, ($sp)
			addi $sp, $sp, 4
			lw $ra, 0($sp)
			li $t0, 0
			sw $t0, flag($v0)
		dfs_if_3_end:
		dfs_if_4:
			addi $t0, $a0, 1
			slt $t0, $t0, $s0
			bne $t0, 1, dfs_if_4_end
			addi $t0, $a0, 1
			sw $ra, 0($sp)
			subi $sp, $sp, 4
			sw $a0, 0($sp)
			subi $sp, $sp, 4
			sw $a1, 0($sp)
			subi $sp, $sp, 4
			move $a0, $s1
			move $a2, $a1
			move $a1, $t0
			jal getIndex
			addi $sp, $sp, 4
			lw $a1, 0($sp)
			addi $sp, $sp, 4
			lw $a0, 0($sp)
			addi $sp, $sp, 4
			lw $ra, 0($sp)
			lw $t0, flag($v0)
			bne $t0, 0, dfs_if_4_end
			lw $t0, matrix($v0)
			bne $t0, 0, dfs_if_4_end
			li $t0, 1
			sw $t0, flag($v0)
			sw $ra 0($sp)
			subi $sp, $sp, 4
			sw $a0, 0($sp)
			subi $sp, $sp, 4
			sw $v0, 0($sp)
			subi $sp, $sp, 4
			addi $a0, $a0, 1
			jal dfs
			addi $sp, $sp, 4
			lw $v0, 0($sp)
			addi $sp, $sp, 4
			lw $a0, ($sp)
			addi $sp, $sp, 4
			lw $ra, 0($sp)
			li $t0, 0
			sw $t0, flag($v0)
		dfs_if_4_end:
		dfs_if_5:
			addi $t0, $a1, 1
			slt $t0, $t0, $s1
			bne $t0, 1, dfs_if_5_end
			addi $t0, $a1, 1
			sw $ra, 0($sp)
			subi $sp $sp, 4
			sw $a0, 0($sp)
			subi $sp, $sp, 4
			sw $a1, 0($sp)
			subi $sp, $sp, 4
			move $a1, $a0
			move $a0, $s1
			move $a2, $t0
			jal getIndex
			addi $sp, $sp, 4
			lw $a1, 0($sp)
			addi $sp, $sp, 4
			lw $a0, 0($sp)
			addi $sp, $sp, 4
			lw $ra, 0($sp)
			lw $t0, flag($v0)
			bne $t0, 0, dfs_if_5_end
			lw $t0, matrix($v0)
			bne $t0, 0, dfs_if_5_end
			li $t0, 1
			sw $t0, flag($v0)
			sw $ra 0($sp)
			subi $sp, $sp, 4
			sw $a1, 0($sp)
			subi $sp, $sp, 4
			sw $v0, 0($sp)
			subi $sp, $sp, 4
			addi $a1, $a1, 1
			jal dfs
			addi $sp, $sp, 4
			lw $v0, 0($sp)
			addi $sp, $sp, 4
			lw $a1, 0($sp)
			addi $sp, $sp, 4
			lw $ra, 0($sp)
			li $t0, 0
			sw $t0, flag($v0)
		dfs_if_5_end:
	dfs_if_1_end:
		jr $ra







	
