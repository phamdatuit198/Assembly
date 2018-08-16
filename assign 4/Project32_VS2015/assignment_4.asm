TITLE Assignment 4    (assignment2.asm)

; Author: Dat Pham
; Course CS 271 / Project ID          Date: 5/13/2017
; Description: Write a program to calculate composite numbers. 



INCLUDE Irvine32.inc

LOWER   = 1
UPPER	= 400
.data

num				    DWORD	?	
numcheck			DWORD	3
counter				DWORD	?
outcounter			DWORD	1
incounter			DWORD	2
counterRow			DWORD	0

title1				BYTE			"Composite Numbers    Programmed by Dat Pham",0
title2				BYTE			"Enter the number of composite numbers you would like to see.",0
title3				BYTE			"I'll accept orders for up to 400 composites.",0
title4				BYTE			"Enter the number of composites to display [1 .. 400]: ",0
space				BYTE			"   ",0
outrange			BYTE			"Out of range.  Try again. ",0
bye 				BYTE			"Results certified by Dat Pham.  Goodbye. ",0
			

.code
main PROC
	call introduction
	call getUserData
	call showComposites
	call farewell
	exit
	main ENDP

;Procedure Introduction
introduction PROC

	; Programmer name and title of assignment

	mov		 edx, OFFSET title1
	call	 WriteString
	call	 CrLf
	call	 CrLf
	; assignment instructions
	mov		edx, OFFSET title2
	call	WriteString
	call	CrLf
	mov		edx, OFFSET title3
	call	WriteString
	call	CrLf
	call	CrLf

	ret

introduction ENDP

;Procedure get data from user
getUserData PROC
	EnterNumber:
					mov		eax, counter
					add		eax, 1
					mov		counter, eax
					mov		edx, OFFSET title4
					call	WriteString
					call    ReadInt
					mov     num, eax
					cmp		eax,LOWER
					jl		errorRange
					cmp		eax, UPPER
					jg		errorRange
					jmp		continue

	errorRange:
					mov		edx, OFFSET outrange
					call	WriteString
					call	CrLf
					jmp		EnterNumber
	continue:
					call	CrLf
	ret
getUserData ENDP

;Procedure show composites
showComposites PROC
	
	;Loop outside for count enought amount user enter
	OutsideLoop:
				mov ebx,outcounter					
				cmp ebx,num
				jg	ExitOutLoop							    ;outcounter > num

				;Increate number for checking
				mov eax,numcheck
				add eax,1
				mov numcheck,eax
				
	;Loop inside for check number is composite or it is not
	InsideLoop:
						mov ebx, incounter
						cmp ebx,numcheck
						jl	CheckNumCompsite				;incouter <= numcheck
						mov incounter, 2
						jmp OutsideLoop

			CheckNumCompsite:
							mov eax,numcheck
							mov ebx, incounter
							sub edx,edx
							cdq
							idiv ebx
							cmp edx,0
							je ExitInsideLoop
							jmp IncreateInCounter
			ExitInsideLoop:	
							mov eax,counterRow
							add eax,1
							mov counterRow,eax
							cmp eax,10
							jg DropLine

			;Display number Composite
			ShowNumberComposite:
							mov eax,numcheck
							call WriteDec
							mov edx,OFFSET space
							call WriteString
							jmp IncreateOutCounter

			;increate incounter
			IncreateInCounter:	
						mov ebx,incounter
						add ebx,1
						mov incounter,ebx
						loop InsideLoop

			;Drop line when enough 10 number 
			DropLine:	
						call Crlf
						mov counterRow,1
						jmp ShowNumberComposite
		
		;Increate outcounter
		IncreateOutCounter:		
				mov incounter, 2
				mov ebx,outcounter
				add ebx,1
				mov outcounter,ebx
				jmp OutsideLoop				

	ExitOutLoop:
		call	CrLf
	ret
					
showComposites ENDP

;Say goodbye
farewell PROC
	call	CrLf
	mov		edx, OFFSET bye
	call	WriteString
	call	CrLf
	call	CrLf
	exit
farewell ENDP
END main
