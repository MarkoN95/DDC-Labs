#
# Sum of Absolute Differences Algorithm with GRB values
#
# Authors:
#	  Marko Nikic
#	  Véronique Kaufmann
#

.text

main:
	lui, $s0, 0x0000         # base address located in $s0
	ori, $s0, 0x0000

	addi, $t0, $0, 3	       # load R1 into memory
	sw $t0, 0($s0)
	addi, $t0, $0, 5	       # load G1 into memory
	sw $t0, 4($s0)
	addi, $t0, $0, 7	       # load B1 into memory
	sw $t0, 8($s0)
	addi, $t0, $0, 11	       # load R2 into memory
	sw $t0, 12($s0)
	addi, $t0, $0, 13	       # laod G2 into memory
	sw $t0, 16($s0)
	addi, $t0, $0, 17	       # load B2 into memory
	sw $t0, 20($s0)

	lw $a0, 0($s0)           # load input into function argument regs
	lw $a1, 4($s0)
	lw $a2, 8($s0)
	lw $a3, 12($s0)
	addi $sp, $sp, -8        # allocate stack space for last two arguments
	lw $t0, 16($s0)
	sw $t0, 4($sp)           # store G2 on the stack
	lw $t0, 20($s0)
	sw $t0, 0($sp)           # store B2 on the stack
	jal abs_diff_color
	addi $sp, $sp, 8         # free stack space
	add $t2, $v0, $0         # store result in $t2

end:
	j end

abs_diff_color:
	addi $sp, $sp, -8        # save $a1 and $ra on stack
	sw $a1, 4($sp)
	sw $ra, 0($sp)
	add $a1, $a3, $0	       # load R2 into $a1 (R1 already in $a0)
	jal abs_diff
	add $t0, $v0, $0         # $t0 = abs_diff(R1, R2)
	lw $a0, 4($sp)		       # load G1 into $a0
	lw $a1, 12($sp)		       # load G2 into $a1
	jal abs_diff
	add $t0, $v0, $t0        # $t0 = abs_diff(R1, R2) + abs_diff(G1, G2)
	add $a0, $a2, $0	       # load B1 into $a0
	lw $a1, 8($sp)		       # load B2 into $a1
	jal abs_diff
	add $v0, $t0, $v0        # $v0 = abs_diff(R1, R2) + abs_diff(G1, G2) + abs_diff(B1, B2)
	lw $ra, 0($sp)           # restore old $ra
	add $sp, $sp 8           # free stack space
	jr $ra

abs_diff:
	sub $t1, $a0, $a1				 # see patent number: 6073150
	sra $t2, $t1, 31
	xor $t1, $t1, $t2
	sub $v0, $t1, $t2
	jr $ra
