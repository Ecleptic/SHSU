	.data

# Make 2 100-byte buffers, 1 and 2, to hold the strings entered by the user.
buf1:	.space 100
buf2:	.space 100

# Prompts for reading strings from user
prmpt1:	.asciiz "\nPlease enter the first string: "
prmpt2:	.asciiz "Please enter the second string: "

# Strings to label the string lengths
len1:	.asciiz "\nThe first string has a length of "
len2:	.asciiz "\nThe second string has a length of "

# Strings to label the word counts
words1:	.asciiz "\n\nThe first string has a word count of "
words2:	.asciiz "\nThe second string has a word count of "

# Strings to label first and second strings
str1:	.asciiz "\n\nThe first string is: "
str2:	.asciiz "The second string is: "

	.text

main:	####### Part 1: Reading in strings #######

	# Prompt for first string
	la	$a0, prmpt1	# $a0 = address of first prompt
	li	$v0, 4		# 4 = syscall code to print string
	syscall			# Print prompt

	# Read in first string
	la	$s0, buf1	# $s0 = address of first buffer
	sw	$s0, 0($sp)	# Adds address of first buffer to top of stack
	jal	INSTRING	# Read string into first buffer

	# Prompt for second string
	la	$a0, prmpt2	# $a0 = address of second prompt
	li	$v0, 4		# 4 = syscall code to print string
	syscall			# Print prompt

	# Read in second string
	la	$s1, buf2	# $s0 = address of second buffer
	sw	$s1, 0($sp)	# Adds address of second buffer to top of stack
	jal	INSTRING	# Read string into second buffer

	####### Part 2: Printing string lengths #######

	# Print label for length of first string
	la	$a0, len1	# $a0 = address of first length label
	li	$v0, 4		# 4 = syscall code to print string
	syscall			# Print length label

	# Find length of first string
	sw	$s0, 0($sp)	# Adds address of first buffer to top of stack
	jal	LENGTH		# Get length of first string in $v0

	# Print length of first string
	sw	$v0, 0($sp)	# Adds length of first string to top of stack
	jal	NUMOUT		# Prints length of first string

	# Print label for length of second string
	la	$a0, len2	# $a0 = address of second length label
	li	$v0, 4		# 4 = syscall code to print string
	syscall			# Print length label

	# Find length of second string
	sw	$s1, 0($sp)	# Adds address of second buffer to top of stack
	jal	LENGTH		# Get length of second string in $v0

	# Print length of second string
	sw	$v0, 0($sp)	# Adds length of second string to top of stack
	jal	NUMOUT		# Prints length of second string

	####### Part 3: Printing word counts #######

	# Print label for word count of first string
	la	$a0, words1	# $a0 = address of first word count label
	li	$v0, 4		# 4 = syscall code to print string
	syscall			# Print word count label

	# Find word count of first string
	sw	$s0, 0($sp)	# Adds address of first buffer to top of stack
	jal	WCOUNT		# Get word count of first string in $v0

	# Print word count of first string
	sw	$v0, 0($sp)	# Adds word count of first string to top of stack
	jal	NUMOUT		# Prints word count of first string

	# Print label for word count of second string
	la	$a0, words2	# $a0 = address of second word count label
	li	$v0, 4		# 4 = syscall code to print string
	syscall			# Print word count label

	# Find word count of second string
	sw	$s1, 0($sp)	# Adds address of second buffer to top of stack
	jal	WCOUNT		# Get word count of second string in $v0

	# Print word count of second string
	sw	$v0, 0($sp)	# Adds word count of second string to top of stack
	jal	NUMOUT		# Prints word count of second string

	####### Part 4: Printing the strings #######

	# Print label for first string
	la	$a0, str1	# $a0 = address of first string label
	li	$v0, 4		# 4 = syscall code to print string
	syscall			# Print first string label

	# Print first string
	sw	$s0, 0($sp)	# Adds address of first buffer to top of stack
	jal	PRINTLN		# Print first string

	# Print label for second string
	la	$a0, str2	# $a0 = address of second word count label
	li	$v0, 4		# 4 = syscall code to print string
	syscall			# Print second string label

	# Print second string
	sw	$s1, 0($sp)	# Adds address of second buffer to top of stack
	jal	PRINTLN		# Print second string

	j	exit		# Exit program

########################
# INSTRING(buffer address): Reads in string from user and stores it at the given buffer address.
# Caller puts buffer address in 0($sp).
INSTRING:
	# Load arguments for read string syscall
	lw	$a0, 0($sp)	# $a0 = buffer address
	li	$a1, 99		# $a1 = max number of characters to store
				# (100th char is reserved for null byte)
	li	$v0, 8		# 8 = syscall code to read string
	syscall			# Read string from user

	# Return
	jr	$ra		# Return value $v0 = address of buffer

# End of INSTRING(buffer address)
########################

########################
# LENGTH(buffer address): Returns number of characters in string stored at given address.
# Count does not include the terminating null byte.
# Caller puts buffer address in 0($sp).
LENGTH:
	# Initiate values for a loop through the string
	lw	$t0, 0($sp)	# $t0 = starting address of string
	li	$v0, 0		# $v0 = letters counted so far = 0

	LENGTHloop:	# This loop goes through each letter in the string, counting letters in $v0.
			# Ends when we get to a null byte or linebreak.

		# Get next letter
		add	$t2, $t0, $v0	# $t2 = base address + letters counted so far = address of next letter
		lb	$t1, 0($t2)	# $t1 = next byte in string (1 letter = 1 byte)

		# If it's a null byte (0) or a newline (\n, ascii code 10), return (count is already in $v0).
		beqz	$t1, return	# If next byte is 0, return.
		beq	$t1, 10, return	# If next byte is \n, return.

		# Otherwise count letter and repeat!
		addi	$v0, $v0, 1	# Add 1 to letter count
		j	LENGTHloop	# restart loop

# End of LENGTH(buffer address)
########################

########################
# WCOUNT(buffer address): Returns number of words in string stored at given address.
# Count includes empty strings, so a buffer containing 5 spaces will give a word count of 6
# (6 empty strings separated by 5 spaces).
# Caller puts buffer address in 0($sp).
WCOUNT:
	# Initiate values for a loop through the string
	lw	$t0, 0($sp)	# $t0 = starting address of string
	li	$v0, 1		# $v0 = space-separated strings counted so far = 1 (empty string at beginning)

	WCOUNTloop:	# This loop goes through each letter in the string, incrementing $v0 if it's a space
			# Ends when we get to a null byte or linebreak.

		# Get next letter
		lb	$t1, 0($t0)	# $t1 = next byte in string (1 letter = 1 byte)

		# Check if it's a space (ascii code 32)
		bne	$t1, 32, notSpace	# If it isn't a space, don't increment $v0
		addi	$v0, $v0, 1		# If it is, add next section to word count (increment $v0)

		notSpace:
		# If it's a null byte (0) or a newline (\n, ascii code 10), return (count is already in $v0).
		beqz	$t1, return	# If next byte is 0, return.
		beq	$t1, 10, return	# If next byte is \n, return.

		# Otherwise increment address and repeat!
		addi	$t0, $t0, 1	# Increment address to next letter
		j	WCOUNTloop	# restart loop

# End of WCOUNT(buffer address)
########################

########################
# PRINTLN(buffer address): Prints each character in buffer until it hits a newline or null byte. Then prints a newline.
# Caller puts buffer address in 0($sp).
PRINTLN:
	# Initiate values for a loop through the string
	lw	$t0, 0($sp)	# $t0 = starting address of string

	PRINTLNloop:	# This loop goes through each letter in the string, printing until it hits newline or null.

		# Get next letter
		lb	$a0, 0($t0)	# $a0 = next byte in string (1 letter = 1 byte)

		# If it's a null byte (0) or a newline (\n, ascii code 10), return (count is already in $v0).
		beqz	$a0, endOfString	# If next byte is 0, stop printing string
		beq	$a0, 10, endOfString	# If next byte is \n, stop printing string

		# Otherwise, print char
		li	$v0, 11		# 11 = syscall code to print character in $a0
		syscall			# Print current character

		# Increment address and repeat!
		addi	$t0, $t0, 1	# Increment address to next letter
		j	PRINTLNloop	# restart loop

	endOfString:

	# Print newline, then return
	li	$a0, 10		# $a0 = ascii code for newline (10)
	li	$v0, 11		# 11 = syscall code to print character in $a0
	syscall			# Print newline
	jr	$ra		# Return

# End of PRINTLN(buffer address)
########################

########################
# NUMOUT(int x) prints x as a base 10 integer. Caller puts x in 0($sp).
NUMOUT:
	# Print x
	lw	$a0, 0($sp)	# $a0 = x
	li	$v0, 1		# 1 = syscall code to print integer
	syscall			# Print x

	jr	$ra		# Return

# End of NUMOUT(int x)
########################

########################
# return() jumps to address in $ra
return:	jr	$ra
# End of return()
########################

########################
# exit() exits program
exit:	li	$v0, 10		# 10 = syscall code to exit
	syscall			# exit
# End of exit()
########################
