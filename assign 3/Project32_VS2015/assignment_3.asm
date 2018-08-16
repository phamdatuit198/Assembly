TITLE Assignment 3     (assignment3.asm)

; Author: Dat Pham
; Course CS 271 / Project ID          Date: 5/03/2017
; Description: Write a program to calculate negative number



INCLUDE Irvine32.inc
MAXSIZE=100
LOWER   = -100
UPPER	= -1
.data

num				    DWORD	?
sum					DWORD	0
counter				DWORD	-1
counterpoint		DWORD	0
first				DWORD	0
second				DWORD	0
third				DWORD	0
average				DWORD   0
remainder			DWORD	0

extra1				BYTE			"**EC: Number the lines during user input.",0
extra2				BYTE			"**EC: Calculate and display the average as a floating-point number, rounded to the nearest .001.",0

title1				BYTE			"Welcome to the Integer Accumulator by Dat Pham",0
title2				BYTE			"What is your name? ",0
title3				BYTE			"Hello, ",0
title4				BYTE			"Please enter numbers in [-100, -1].",0
title5				BYTE			"Enter a non-negative number when you are finished to see results.",0
title6				BYTE			"Enter number: ",0
title7				BYTE			"You entered ",0
title8				BYTE			" valid numbers.",0
title9				BYTE			"The sum of your valid numbers is ",0
title10				BYTE			"The rounded average is ",0
title11				BYTE			"Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ",0
title12				BYTE			"Display the average as a floating-point number ",0
inString			BYTE			MAXSIZE DUP(?)
outString			BYTE			MAXSIZE	DUP(?)

space				BYTE			" ",0
point				BYTE			".",0

.code
main PROC

;Display instructions line 1
	mov edx,OFFSET title1				
	call WriteString
	call Crlf

;Display instruction extra1
	mov edx,OFFSET extra1
	call WriteString
	call Crlf

;Display instruction extra2
	mov edx,OFFSET extra2
	call WriteString
	call Crlf

;Display Enter User name line 2
	mov edx,OFFSET title2
	call WriteString
	mov edx,OFFSET inString
	mov ecx,MAXSIZE
	call ReadString

;Display show name of user line 3
	mov edx,OFFSET title3
	call WriteString
	mov edx,OFFSET inString
	call WriteString
	call Crlf
	call Crlf

;Display instructions line 4
	mov edx,OFFSET title4
	call WriteString
	call Crlf

;Display instructions line 5
	mov edx,OFFSET title5
	call WriteString
	call Crlf

;Enter number negative integer
	
EnterNumber:
	mov eax,counter
	inc eax
	mov counter,eax

;Display number of line
	add eax,1
	call WriteDec
	mov edx,OFFSET space
	call WriteString

;Read number from keyboard
	mov edx,OFFSET title6
	call WriteString
	call ReadInt
	mov num,eax

;Check number is Ranking
	mov eax,num
	cmp eax,UPPER
	jg Calculate
	cmp eax,LOWER
	jb Calculate

;Sum negative number
	add eax,sum
	mov sum,eax
	loop EnterNumber

Calculate:
;Check counter is zero
	mov eax,counter
	cmp eax,0
	je GoodBye

;Display Counter line 6
	mov edx,OFFSET title7
	call WriteString
	mov eax,counter
	Call WriteDec
	mov edx,OFFSET title8
	call WriteString
	call Crlf

;Display sum of negative number line 7
	mov edx,OFFSET title9
	call WriteString
	mov eax,sum
	call WriteInt
	call Crlf

;Display Average number line 8
	mov edx,OFFSET title10
	call WriteString
	mov eax,sum
	mov ebx, counter
	cdq
	idiv ebx
	mov average,eax
	call WriteInt
	call Crlf


;Save Remainder with positive value
	mov eax,sum
	neg eax
	mov ebx,counter
	cdq
	idiv ebx

CalculatePoint:
	mov remainder,edx
	mov eax,counterpoint
	add eax,1
	mov counterpoint,eax
	cmp eax,4
	je FloatingPoint

	mov eax,remainder
	imul eax,10
	mov ebx, counter
	cdq
	idiv ebx
	
	mov ecx,counterpoint
	cmp ecx,1
	je FirstPoint
	cmp ecx,2
	je SecondPoint
	cmp ecx,3
	je ThirdPoint
	jmp Calculatepoint

FirstPoint:
	mov first, eax
	jmp Calculatepoint

SecondPoint:
	mov second,eax
	jmp Calculatepoint

ThirdPoint:
	mov third,eax
	jmp Calculatepoint
	

FloatingPoint:
	mov edx,OFFSET title12
	call WriteString
	mov eax,average
	Call WriteInt
	
	mov edx,OFFSET point
	call WriteString
	mov eax,first
	call WriteDec
	mov eax,second
	call WriteDec
	mov eax,third
	call WriteDec
	call Crlf


;Display say good bye
GoodBye:
	mov edx,OFFSET	title11
	call WriteString
	mov edx,OFFSET inString
	call WriteString
	mov edx,OFFSET point
	call WriteString
	call Crlf
	exit;


main ENDP
END main
