#
# Seamus Gosman
# CIS 213
# Assignment 9 payroll Loop
# 

	.text			# instructions
	.globl main		# set main to global

main:				# main

	li.s $f1, 0.0		# float for hourly
	li.s $f2, 0.0		# float for wage
	li.s $f3, 0.0		# register for float comparisons 
	li $t0, 0		# counter 

wageLoop:			# do while loop for wage input

	la $a0, hourlyWage	# load wage prompt for printing
	li $v0, 4		# syscall for printing string
	syscall			# print prompt

	li $v0, 6		# syscall for reading float
	syscall			# read input

	# loop	
	mov.s $f1, $f0		# move input value to $f0
	c.lt.s $f3, $f1		# set conditional bit to false
	add $t0, $t0, 1		# $t0++
	bc1f wageError		# while bit = false, jump tp wageError

	li $t0, 0		# reset the counter to 0
	j hourLoop		# jump to hourLoop

wageError:				# error message for wageLoop

	blt $t0, 1, wageLoop		# if counter < 1   	
	la $a0, error			# load error message
	li $v0, 4			# syscall for printing a string
	syscall				# print error message
	j wageLoop			# jump back to wageLoop
	
hourLoop:				# loop for hourly input

	la $a0, hoursWorked		# load prompt
	li $v0, 4			# set the syscall for printing a string
	syscall				# print prompt
	
	li $v0, 6			# set syscall for reading float
	syscall				# read float
	
	# loop
	mov.s $f2, $f0			# move input to $f0
	c.lt.s $f3, $f2			# set conditional bit to false
	add $t0, $t0, 1			# $t0++
	bc1f hourError			# jump to hourly error

	j results			# jump to results

hourError:				# error message for hourLoop

	blt $t0, 1, hourLoop		# if count < 1 , continue
	la $a0, error			# load error message
	li $v0, 4			# set syscall for printing string
	syscall				# print prompt
	j hourLoop 			# jump to hour loop
		
results:

	la $a0, totalPay		# load totalPay prompt
	li $v0, 4			# set the syscall for printing a string
	syscall				# print prompt

	li $v0, 2			# set syscall for printing a float
	mul.s $f12, $f1, $f2		# $f12 = $f1 * $f2
	syscall				# print $f12

	li $v0, 10			# set syscall to exit
	syscall				# exit program	

	.data

hourlyWage: .asciiz "\nPlease enter the employee's hourly wage: " # prompt for wage
hoursWorked: .asciiz "\nPlease enter the hours worked: "	  # prompt for hours
totalPay: .asciiz "\nThe employee's total pay is: "		  # display employee total
error:	.asciiz "\nInvalid Input: Please Try Again\n"		  # error message