TITLE Assignment 2     (assignment2.asm)

; Author: Dat Pham
; Course CS 271 / Project ID          Date: 4/20/2017
; Description: Write a program to calculate Fibonacci number



INCLUDE Irvine32.inc
MAXSIZE = 100
LOWER   = 1
UPPER	= 46
.data

num				    DWORD	?	
num1				DWORD	?
num2				DWORD	?
counter				DWORD	?
counterRow			DWORD	?
inString			BYTE			MAXSIZE DUP(?)
outString			BYTE			MAXSIZE DUP(?)
title1				BYTE			"Fibonacci Numbers",0
title2				BYTE			"Programmed by Leonardo Pisano",0
title3				BYTE			"Enter the number of Fibonacci terms to be displayed",0
title4				BYTE			"Give the number as an integer in the range [1 .. 46].",0

input1				BYTE			"What's your name? ",0
input2				BYTE			"Hello, ",0
input3				BYTE			"How many Fibonacci terms do you want? ",0
outRange			BYTE			"Out of range. Enter a number in [1..46] ",0
bye1				BYTE			"Results certified by Leonardo Pisano.",0
bye2				BYTE			"Goodbye, ",0
space				BYTE			"    ",0
			

.code
main PROC

;Display instructions line 1
	mov edx,OFFSET title1				
	call WriteString
	call Crlf
	

;Display instructions line 2
	mov edx,OFFSET title2
	call WriteString
	call Crlf
	call Crlf

;Enter name of user
	mov edx,OFFSET input1
	call WriteString
	mov edx,OFFSET inString
	mov ecx,MAXSIZE
	call ReadString
	call Crlf

;Display show name of user
	mov edx,OFFSET input2
	call WriteString
	mov edx,OFFSET inString
	call WriteString
	call Crlf

;Display instructions line 3
	mov edx,OFFSET title3
	call WriteString
	call Crlf

;Display instructions line 4
	mov edx,OFFSET title4
	call WriteString
	call Crlf

;Enter number Fibonacci term
EnterNumber:
	mov edx,OFFSET input3
	call WriteString
	call ReadInt
	mov num,eax

;Check number Fibonacci 
	mov eax,num;
	cmp eax,LOWER
	jl WrongNumber
	cmp eax,UPPER
	jg WrongNumber

;Calculate Fibonacci number 
	mov eax,1
	mov num1,eax
	Call WriteDec
	mov edx,OFFSET space
	Call WriteString

;Check if user enter 1
	mov ebx,num
	cmp ebx,1
	je Finish

	mov ebx,1
	mov num2,ebx
	Call WriteDec
	mov edx,OFFSET space
	Call WriteString

;Check if user enter 2
	mov ebx,num
	cmp ebx,2
	je Finish

	mov ecx,3
	mov counter,ecx
	mov ecx,2
	mov counterRow,ecx

Filoop:

	mov ecx,counterRow
	cmp ecx,5
	je StartRow
	inc ecx
	mov counterRow,ecx

	mov eax,num1
	mov ebx,num2
	add eax,ebx
	Call WriteDec

	mov edx,OFFSET space
	Call WriteString

	mov num1,ebx
	mov num2,eax

	mov ecx,counter
	inc ecx
	mov counter,ecx
	mov eax,num
	
	cmp counter,eax
	jle Filoop
	jg Finish

StartRow:
	call Crlf
	mov ecx,0
	mov counterRow,ecx
	jg Filoop

;Display say good bye1
Finish:
	call Crlf
	call Crlf
	mov edx,OFFSET	bye1
	call WriteString
	call Crlf

;Display show name of user
	mov edx,OFFSET bye2
	call WriteString
	mov edx,OFFSET inString
	call WriteString
	call Crlf
	exit	; exit to operating system


WrongNumber:
	call Crlf
	mov edx,OFFSET outRange				
	call WriteString
	call Crlf
	jmp EnterNumber

main ENDP
END main
