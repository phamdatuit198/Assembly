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
dat BYTE ?
thinh BYTE ?
title1				BYTE			"	Elementary Arithmetic		by Dat Pham",0
title2				BYTE			"Enter 2 numbers, and I'll show you the sum, difference,",0
title3				BYTE			"product, quotient, and remainder.",0
bye					BYTE			"Impressed? Bye!",0
prompt1				BYTE			"First number: ",0
prompt2				BYTE			"Second number: ",0

outadd				BYTE			" + ",0
outsub				BYTE			" - ",0
outmultip			BYTE			" x ",0
outdivi 			BYTE			" / ",0
outequal			BYTE			" = ",0
outremainder		BYTE			"  Remainder: ",0


yes    BYTE     "Yes",0
no     BYTE     "No",0
maybe  BYTE     "Maybe",0

.code
main PROC

 mov   eax, 1
   cmp   AH, dat
 

   jg    option1
   jmp   option3
option1:
   mov   edx, OFFSET yes
   call  WriteString
   jmp   endOfProgram
option2:
   mov   edx, OFFSET no
   call  WriteString
   jmp   endOfProgram
option3:
   mov   edx, OFFSET maybe
   call  WriteString
endOfProgram:
   exit
main ENDP
END main
