# Helloworld

	.data
msg: .asciiz "Hello World\n"
msg2: .asciiz "Goodbye, cruel world ...\n"

	.text
	li $v0, 4 	#syscall 4 (print_str)
	la $a0, msg	#argument: string
	syscall		#print String
	
	li $v0, 4	#Syscall 4 = print string
	la $a0, msg2	#argument: string
	syscall		#print String
	
	li $v0, 10 	#system call exit
	syscall		#done