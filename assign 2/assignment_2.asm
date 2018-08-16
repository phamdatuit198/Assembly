TITLE Assignment 3     (assignment3.asm)

; Author: Dat Pham
; Course CS 271 / Project ID          Date: 4/20/2017
; Description: Write a program to enter and calculate negative number



INCLUDE Irvine32.inc

LOWER   = -1
UPPER	= -100

.data

num				    DWORD	?	
num1				DWORD	?
num2				DWORD	?
counter				DWORD	?

title1				BYTE			"Welcome to the Integer Accumulaor by Austin Miller",0
title2				BYTE			"Please enter numbers in [-100, -1]",0
title3				BYTE			"Enter a non-negative number when you are finished to see results.",0

input1				BYTE			"What is your name? ",0
input2				BYTE			"Hello, ",0
input3				BYTE			"Enter number: ",0

output1				BYTE			"You entered ",0
output2				BYTE			"valid numbers.",0
output3				BYTE			"The sum of your valid numbers is ",0
output4				BYTE			"The rounded average is ",0

bye					BYTE			"Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ",0
str1	BYTE	"Introduction",0

			

.code
main PROC


mov	esi, OFFSET str1
	add	esi, 5
	mov	ecx, 4
	cld
more1:
	lodsb
	call	WriteChar
	loop	more1

	mov	ecx, 4
	std
more2:
	lodsb
	call	WriteChar
	loop	more2

main ENDP
END main
