Loop:
lw $t2, 0x7f58($0)
li $t4, 1
beq $t2, $t4, Add
sll $t4, $t4, 1
beq $t2, $t4, Sub
sll $t4, $t4, 1
beq $t2, $t4, Or
sll $t4, $t4, 1
beq $t2, $t4, And
sll $t4, $t4, 1
beq $t2, $t4, Nor
sll $t4, $t4, 1
beq $t2, $t4, Xor
sll $t4, $t4, 1
beq $t2, $t4, Sllv
sll $t4, $t4, 1
beq $t2, $t4, Srlv
nop
j Loop
nop

Add:
lw $t0, 0x7f50($0)
lw $t1, 0x7f54($0)
addu $t3, $t1, $t0
sw $t3, 0x7f44($0)
j Loop
nop

Sub:
lw $t0, 0x7f50($0)
lw $t1, 0x7f54($0)
subu $t3, $t1, $t0
sw $t3, 0x7f44($0)
j Loop
nop

Or:
lw $t0, 0x7f50($0)
lw $t1, 0x7f54($0)
or $t3, $t1, $t0
sw $t3, 0x7f44($0)
j Loop
nop

And:
lw $t0, 0x7f50($0)
lw $t1, 0x7f54($0)
and $t3, $t1, $t0
sw $t3, 0x7f44($0)
j Loop
nop

Nor:
lw $t0, 0x7f50($0)
lw $t1, 0x7f54($0)
nor $t3, $t1, $t0
sw $t3, 0x7f44($0)
j Loop
nop

Xor:
lw $t0, 0x7f50($0)
lw $t1, 0x7f54($0)
xor $t3, $t1, $t0
sw $t3, 0x7f44($0)
j Loop
nop

Sllv:
lw $t0, 0x7f50($0)
lw $t1, 0x7f54($0)
sllv $t3, $t1, $t0
sw $t3, 0x7f44($0)
j Loop
nop

Srlv:
lw $t0, 0x7f50($0)
lw $t1, 0x7f54($0)
srlv $t3, $t1, $t0
sw $t3, 0x7f44($0)
j Loop
nop
