#
# Calculate sum from A to B.
#
# Authors:
#	  Marko Nikic
#   Véronique Kaufmann
#

.text

main:
	addi $t0, $0, 10   # i = A
	addi $t1, $0, 21   # B + 1
	addi $t2, $0, 0    # sum

loop:
	beq $t0, $t1, end  # exit if i == B + 1
	add $t2, $t2, $t0  # sum += i
	addi $t0, $t0, 1   # i++
	j loop

end:
	j	end
