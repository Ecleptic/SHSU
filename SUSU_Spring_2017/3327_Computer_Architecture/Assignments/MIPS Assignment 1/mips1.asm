.data
	prompt: .asciiz "Enter a number to add. Type '0' to close \n"
	total: .asciiz "\nCurrent total: "
.text 

# prompt user
li $v0,4           #we're saying we want to print.
la $a0, prompt     #loading prompt
syscall

#START LOOP
#add.d $s0,0    #make sure t0 = 0 "i = 0";

while:

#get input
li $v0, 5   #get input, stored in v0
syscall

beq $v0,0, exit ##if 0 then exit

add $s0, $v0,$s0 #else, add input to t0 (might currently only work with binary)

#print current total
 li $v0,4           #we're saying we want to print.
la $a0, total     #loading total
 syscall

# total
li $t0, 1 
move $a0, $t0
syscall

j while

exit: 

#END LOOP



li $v0, 10 	#system call exit
syscall		#done