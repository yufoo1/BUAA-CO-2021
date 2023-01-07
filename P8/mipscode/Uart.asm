.text
    li $t0, 0x1001
    mtc0 $t0, $12
    
Loop:
	# main procedure
    j Loop
    nop

.ktext 0x4180
    lw $t1, 0x7f20($0)
    sw $t1, 0x7f44($0)
    sw $t1, 0x7f20($0)
    eret
    nop
    
    
    
    
