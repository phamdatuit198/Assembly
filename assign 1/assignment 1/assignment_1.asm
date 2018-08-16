TITLE Assignment 1     (assignment1.asm)

; Author: Dat Pham
; Course CS 271 / Project ID          Date: 4/11/2017
; Description: Enter 2 number, and show sum, difference product, quotient, and remainder



INCLUDE Irvine32.inc

.data

num1				DWORD	?	
num2				DWORD	?		
resultsum			DWORD	?
resultsub			DWORD	?
resultmultip		DWORD   ?
resultdivi			DWORD	?
remainder			DWORD	?

title1				BYTE			"	Elementary Arithmetic		by Dat Pham",0
title2				BYTE			"Enter 2 numbers, and I'll show you the sum, difference,",0
title3				BYTE			"product, quotient, and remainder.",0
bye					BYTE			"Impressed? Bye!",0
prompt1				BYTE			"First number: ",0
prompt2				BYTE			"Second number: ",0
less				BYTE			"The second number must be less than the first!",0
extra				BYTE			"**EC: Program verifies second number less than first.",0

outadd				BYTE			" + ",0
outsub				BYTE			" - ",0
outmultip			BYTE			" x ",0
outdivi 			BYTE			" / ",0
outequal			BYTE			" = ",0
outremainder		BYTE			"  Remainder: ",0
.code
main PROC

;Display instructions line 1
	mov edx,OFFSET title1				;set up for call to WriteString
	call WriteString
	call Crlf
	
;Display extra credit option 2
	mov edx,OFFSET extra
	call WriteString
	call Crlf
	call Crlf

;Display instructions line 2
	mov edx,OFFSET title2
	call WriteString
	call Crlf

;Display instructions line 3
	mov edx,OFFSET title3
	call WriteString
	call Crlf
	call Crlf

;Get an integer for a
	mov	edx,OFFSET prompt1
	call	WriteString
	call	ReadInt
	mov	num1,eax

;Get an integer for b
	mov	edx,OFFSET prompt2
	call	WriteString
	call	ReadInt
	mov	num2,eax

;Check number
	mov  eax,num1
	mov  ebx,num2
	cmp  eax,ebx
	jl  NumberLessThan

;Add accumulator
	mov eax, num1
	add eax, num2
	

;Save sum result
	mov	resultsum,eax

;Sub accumulator
	mov  eax,num1
	sub  eax,num2

;Save sub result
	mov resultsub,eax

;Mul accumulator
	mov eax,num1
	mov ebx,num2
	imul ebx,eax
	
;Save mul result
	mov resultmultip,ebx

;Div accumulator
	mov eax,num1
	mov ebx,num2
	sub edx,edx
	idiv ebx
	
;Save div result
	mov resultdivi,eax

;Remainder 
	mov eax,num1
	mov ebx,num2
	sub edx,edx
	cdq
	idiv ebx
;Save Remainder 
	mov remainder,edx
	call Crlf
	call Crlf

;Identify and display the result of sum
	mov	eax, num1	
	call	WriteDec				;display first number

	mov	edx,OFFSET outadd
	call	WriteString				;display " + "

	mov	eax, num2	
	call	WriteDec				;display first second

	mov	edx,OFFSET outequal
	call	WriteString				;display " = "

	mov eax,resultsum
	call	WriteDec
	call Crlf

;Identify and display the result of subtraction
	mov	eax, num1	
	call	WriteDec				;display first number

	mov	edx,OFFSET outsub
	call	WriteString				;display " - "

	mov	eax, num2	
	call	WriteDec				;display first second

	mov	edx,OFFSET outequal
	call	WriteString				;display " = "

	mov eax,resultsub
	call	WriteDec
	call Crlf

;Identify and display the result of multiplication
	mov	eax, num1	
	call	WriteDec				;display first number

	mov	edx,OFFSET outmultip
	call	WriteString				;display " * "

	mov	eax, num2	
	call	WriteDec				;display first second

	mov	edx,OFFSET outequal
	call	WriteString				;display " = "

	mov eax,resultmultip
	call	WriteDec
	call Crlf
;Identify and display the result of multiplication
	mov	eax, num1	
	call	WriteDec				;display first number

	mov	edx,OFFSET outdivi
	call	WriteString				;display " / "

	mov	eax, num2	
	call	WriteDec				;display first second

	mov	edx,OFFSET outequal
	call	WriteString				;display " = "

	mov eax,resultdivi
	call	WriteDec

	mov	edx,OFFSET outremainder
	call	WriteString				;display " Remainder:  "

	mov eax,remainder
	call	WriteDec
	call Crlf
	call Crlf

	mov al,72h
	xor al,0A5h

	call	WriteDec				;display first number

;Display say good bye
	call Crlf
	call Crlf
	mov edx,OFFSET	bye
	call WriteString
	call Crlf

	exit	; exit to operating system

NumberLessThan:
	call Crlf
	mov edx,OFFSET less				
	call WriteString

;Display say good bye
	call Crlf
	call Crlf
	mov edx,OFFSET	bye
	call WriteString
	call Crlf

	exit	; exit to operating system
main ENDP
END main
