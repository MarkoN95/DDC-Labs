#
# Sum of Absolute Differences Algorithm
#
# Authors:
#		Marko Nikic
#		Véronique Kaufmann
#

.text

main:
	lui $s0, 0x0000					# base address located in $s0
	ori $s0, 0x0000

	addi $t0, $0, 5					# left_image[0]
	sw $t0, 0($s0)
	addi $t0, $0, 16				# left_image[1]
	sw $t0, 4($s0)
	addi $t0, $0, 7					# left_image[2]
	sw $t0, 8($s0)
	addi $t0, $0, 1					# left_image[3]
	sw $t0, 12($s0)
	addi $t0, $0, 1					# left_image[4]
	sw $t0, 16($s0)
	addi $t0, $0, 13				# left_image[5]
	sw $t0, 20($s0)
	addi $t0, $0, 2					# left_image[6]
	sw $t0, 24($s0)
	addi $t0, $0, 8					# left_image[7]
	sw $t0, 28($s0)
	addi $t0, $0, 10				# left_image[8]
	sw $t0, 32($s0)

	addi $t0, $0, 4					# right_image[0]
	sw $t0, 36($s0)
	addi $t0, $0, 15				# right_image[1]
	sw $t0, 40($s0)
	addi $t0, $0, 8					# right_image[2]
	sw $t0, 44($s0)
	addi $t0, $0, 0					# right_image[3]
	sw $t0, 48($s0)
	addi $t0, $0, 2					# right_image[4]
	sw $t0, 52($s0)
	addi $t0, $0, 12				# right_image[5]
	sw $t0, 56($s0)
	addi $t0, $0, 3					# right_image[6]
	sw $t0, 60($s0)
	addi $t0, $0, 7					# right_image[7]
	sw $t0, 64($s0)
	addi $t0, $0, 11				# right_image[8]
	sw $t0, 68($s0)

	addi $s1, $0, 0  				# $s1 = i = 0
	addi $s2, $0, 9 				# $s2 = image_size = 9
	addi $s3, $s0, 72 			# $s3 = int sad_array[9] (addresses [72, 104])

loop:
	beq $s1, $s2, end_loop 	# exit if i == image_size
	sll $t0, $s1, 2					# make i word aligned
	add $t0, $s0, $t0				# add the base address of $s0
	lw $a0, 0($t0) 					# load left_image[i]
	addi $t0, $t0, 36 			# right_image base address has offset 4 * image_size = 36
	lw $a1, 0($t0) 					# load right_image[i]
	jal abs_diff
	sll $t0, $s1, 2					# make i word aligned
	add $t0, $s3, $t0 			# add the base address of sad_array
	sw $v0, 0($t0)					# store sad_array[i]
	addi $s1, $s1, 1				# i++
	j loop

end_loop:
	add $a0, $0, $s3				# load sad_array
	add $a1, $0, $s2				# load image_size
	jal recursive_sum
	add $t2, $0, $v0				# store result in $t2

end:
	j	end

abs_diff:
	sub $t1, $a0, $a1
	sra $t2, $t1, 31
	xor $t1, $t1, $t2
	sub $v0, $t1, $t2
	jr $ra

recursive_sum:
	addi $sp, $sp, -8       # Adjust sp
  addi $t0, $a1, -1       # Compute size - 1
  sw $t0, 0($sp)        	# Save size - 1 to stack
  sw $ra, 4($sp)        	# Save return address
  bne $a1, $zero, else  	# size == 0 ?
  addi $v0, $0, 0        	# If size == 0, set return value to 0
  addi $sp, $sp, 8        # Adjust sp
  jr $ra                  # Return

else:
	add $a1, $t0, $0				# update the second argument
	jal	recursive_sum
  lw $t0, 0($sp)       		# Restore size - 1 from stack
  sll	$t1, $t0, 2        	# Multiply size by 4
  add	$t1, $t1, $a0     	# Compute & arr[ size - 1 ]
  lw $t2, 0($t1)       		# $t2 = arr[ size - 1 ]
  add	$v0, $v0, $t2     	# retval = $v0 + arr[size - 1]
  lw $ra, 4($sp)       		# restore return address from stack
  addi $sp, $sp, 8        # Adjust sp
  jr $ra                  # Return
