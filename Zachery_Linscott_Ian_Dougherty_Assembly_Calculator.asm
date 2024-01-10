# Zachery Linscott & Ian Dougherty | CS350 Final Project | Nov. 2020

# Numerical calculator

# Steps:
# 1. Input operation type
# 2. Input operands
# 3. Get the result
# 4. Ask user when to end (y/n)

.data

num1: .asciiz "Please enter your first number: \n"
num2: .asciiz "Plese enter your second number: \n"
op:  .asciiz "Please enter your operator (- or +): \n"
continue: .asciiz "Would you like to continue? (y/n) \n"
answer: .asciiz "Your answer is: \n"
nl: .asciiz "\n"
bye: .asciiz "Thanks for using our calculator!"
longmenu: .asciiz "What option would you like to perorm? Please enter using numbers 1 to 7 \n 1. Addition \n 2. Subtraction \n 3. Multiplication \n 4. Division \n 5. Modulo \n 6. Summation (loop) \n 7. Factorial \n 8. Square \n 9. Exponent \n"

.text

.globl main

main:

loop:
   
# print menu options/operations
li $v0, 4
la $a0, longmenu
syscall
li $v0, 5
syscall
move $s0, $v0

# ask user for num1 and store
li $v0, 4
la $a0, num1
syscall
li $v0, 5
syscall
move $t2, $v0

# skip asking for second num if factorial or square operation
beq $s0, 7 factorial
beq $s0, 8 square

# ask user for num2 and store
li $v0, 4
la $a0, num2
syscall
li $v0, 5
syscall
move $t3, $v0
	
# branch to 
# based on given operation
beq $s0, 1 addition
beq $s0, 2 subtract
beq $s0, 3 multiplication 
beq $s0, 4 division 
beq $s0, 5 modulo 
beq $s0, 6 summation 
beq $s0, 9 exponent 


# ask the user if they want to continue
option:
  
# print answer text
li $v0, 4
la $a0, answer
syscall

# print actual answer
li $v0, 1
move $a0, $t5
syscall

# new line
li $v0, 4
la $a0, nl
syscall



cont:  
# ask user if they want to continue
li $v0, 4
la $a0, continue
syscall

# take in y or n from user input
li $v0, 12
syscall
move $t4, $v0

# questionable new line
li $v0, 4
la $a0, nl
syscall

# branch back to loop or quit
beq $t4, 0x79 loop
beq $t4, 0x6e exit
j cont


# user option 1
addition:
add $t5, $t2, $t3 
j option


# user option 2
subtract:
sub $t5, $t2, $t3
j option


# user option 3
multiplication:
mul $t5, $t3, $t2
j option


# user option 8
square:
mul $t5, $t2, $t2
j option


# user option 4
division:
div $t5, $t2, $t3
j option


# user option 5
modulo:
div $t6, $t2, $t3
mul $t6, $t6, $t3
sub $t5, $t2, $t6
j option


# user option 7
factorial:
li $t5, 0
add $t5, $t5, $t2

loop2:
addi $t2, $t2, -1
ble $t2, $zero option
beq $t2, $zero option
mul $t5, $t5, $t2
j loop2


# user option 6
summation:
li $t5, 0

loop3:
bgt $t2, $t3, option
add $t5, $t5, $t2
addi $t2, $t2, 1
j loop3


# user option 9
exponent:
li $t5, 1

loop4:
beq $t3, $zero, option
mul $t5, $t2, $t5
addi $t3, $t3, -1
j loop4


# print exit message and quit
exit:
li $v0, 4
la $a0, bye
syscall
li $v0, 10
syscall