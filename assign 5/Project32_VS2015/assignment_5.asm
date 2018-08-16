TITLE Assignment 2     (assignment2.asm)

; Author: Dat Pham
; Course CS 271 / Project ID          Date: 5/25/2017
; Description: Write a program get list random number and sort list number



INCLUDE Irvine32.inc

LOWER   = 10
UPPER	= 200
SIZEARRAY = 200
MAX = 999
MIN = 100
NUMBERROW = 10
.data

many				DWORD	?	
median				DWORD	?
save				DWORD	?
num 				DWORD	?
counterRow			DWORD	10
arrayNumber			DWORD SIZEARRAY DUP(?)

title1				BYTE			"Sorting Random Integers		Programmed by Dat Pham",0
title2				BYTE			"This program generates random numbers in the range [100 .. 999],",0
title3				BYTE			"display the original list,sorts the list, and calculates the",0
title4				BYTE			"median value. Finally, it displays the list sorted in descending order.",0

input				BYTE			"How many numbers should be generated? [10 .. 200]: ",0
output1				BYTE			"Invalid input",0
output2				BYTE			"The unsorted random numbers: ",0
output3				BYTE			"The median is ",0
output4				BYTE			"The sorted list: ",0
space				BYTE			"    ",0
			

.code


main PROC

;call introduction
		call Introduction;

;call getdata 
		call CrLf
		push OFFSET many
		call GetData
		call CrLf
		call CrLf

;Get random number and push to array number
		push OFFSET arrayNumber
		push many
		call AddArray
		
;Display array number before sort
		mov  edx, OFFSET output2
		call WriteString
		call CrLf
		push OFFSET arrayNumber
		push many
		call DisplayList
		call CrLf
		call CrLf

;Sort array of number
		push OFFSET arrayNumber
		push many
		call SortList

;Display Median
		call CrLf
		push OFFSET arrayNumber
		push many
		call DisplayMedian

;Display array number after sort
		call CrLf
		call CrLf
		mov  edx, OFFSET output4
		call WriteString
		call CrLf
		push OFFSET arrayNumber
		push many
		call DisplayList
		call CrLf

exit
main ENDP



;**********************************************************************************************
;**									INTRODUCTION PROCEDURE
;**
;** Description		  : Display assignment information of program 5	 
;** Preconditions	  : title1, title2, title3, title4 should be set to strings data type
;** Registers Changed : edx
;** Returns			  : don't have return
;**
;***********************************************************************************************



Introduction PROC

	; Display name of program and my name 
	mov		 edx, OFFSET title1			;line 1
	call	 WriteString
	call	 CrLf

	; Display assignment instruction
	mov		edx, OFFSET title2			;line 2
	call	WriteString
	call	 CrLf

	mov		edx, OFFSET title3			;line 3
	call	WriteString
	call	 CrLf

	mov		edx, OFFSET title4			;line 4
	call	WriteString
	call	CrLf

	ret

introduction ENDP

;*************************************************************************
;**							GETDATA PROCEDURE
;**
;** Description		  : Function will get value from user and save.
;** Preconditions	  :	many variable should be DWORD
;** Receives		  : get many variable, LOWER and UPPER constant 
;** Registers Changed : edx, eax
;** Returns			  :	Enter value to many variable
;**
;*************************************************************************

GetData PROC

	push ebp
	mov	 ebp, esp
	mov	 ebx, [ebp + 8] ; get address of many variable into ebx    

	EnterNumberLoop:

		;Enter number
		mov	edx, OFFSET input
		call WriteString
		call ReadInt
		
		mov	num, eax
		mov [ebx], eax		;save number
		cmp	num, UPPER		;check number with upper >200
		jg	Error
		cmp	num, LOWER		;check number with lower < 10
		jb	Error
		jmp	Next
		
	Error:
		mov	edx, OFFSET output1
		call WriteString
		call CrLf
		jmp	EnterNumberLoop
	
	Next:
		pop ebp
	ret 4 ;
getData ENDP


;************************************************************************
;**						FILLARRAY PROCEDURE
;**
;** Description			: Add random number to array
;** Receives			: arraynumber and number many user enter 
;** Returns				: don't return
;** Preconditions		: Array should be between 10 and 200
;** Registers Changed	: eci,eax,ebx.ecx
;**
;*************************************************************************

AddArray PROC

	push ebp
	mov  ebp, esp
	mov  esi, [ebp + 12]		; get address of array    
	mov	 ecx, [ebp + 8]   

	AddLoop:
		mov	eax, MAX		;Make random 0 to 999
		mov	ebx, MIN
		sub	eax, ebx		;Make random 100 to 999
		call RandomRange
		add	eax, MIN		
		mov	[esi], eax		; save into array
		add	esi, 4			
		loop AddLoop

	pop  ebp
	ret  8

AddArray ENDP


;************************************************************************
;**						DISPLAYLIST PROCEDURE
;**
;** Description			: display element value to user
;** Receives			: arrayNumber and many variable form main
;** Returns				: don't return
;** Preconditions		: many should have value between 10 and 200
;** Registers Changed	: ebx,eax,ecx,edx
;**
;*************************************************************************

DisplayList PROC
	push ebp
	mov  ebp, esp
	mov	 ebx, 1			  
	mov  esi, [ebp + 12] 
	mov	 ecx, [ebp + 8]  

	DisplayLoop:
		mov	eax, [esi]			; copy current element to eax
		call WriteDec
		mov	edx, OFFSET space
		call WriteString
		cmp	ebx, NUMBERROW		; check enough 10 element for one line
		je	DropLine
		inc	ebx
		add	esi, 4				; move address for next element
		loop DisplayLoop
		jmp Next
	DropLine:
		call CrLf
		mov	ebx,0
		inc	ebx
		add	esi, 4				; move address for next element
		loop DisplayLoop
	Next:
	pop	 ebp
	ret	 8
DisplayList ENDP




;************************************************************************
;**						SORTLIST PROCEDURE
;**
;** Description			: sort array number 
;** Receives			: arrayNumber and many variable form main
;** Returns				: don't return
;** Preconditions		: many should have value between 10 and 200
;** Registers Changed	: ebx,eax,ecx,edx
;**
;*************************************************************************

SortList PROC
	push ebp
	mov  ebp, esp
	mov  esi, [ebp + 12]			
	mov	 ecx, [ebp + 8]				
	dec	 ecx

	OutsideLoop:
		mov	eax, [esi]			
		mov	edx, esi
		push ecx		
		
		InsideLoop:
			mov	ebx, [edx]			
			mov	eax, [esi+4]
			cmp	ebx, eax
			jl	Swap				;continue if greater
			add	esi,4
			loop InsideLoop
			jmp Next

		Swap:
			add	esi, 4				;swap two element
			push esi
			push edx
			push ecx
			call Exchange
			sub	esi, 4
			add	esi,4
			loop InsideLoop

		Next:
			pop	ecx 			
			mov	esi, edx		
		
			add	esi, 4				;next number
			loop OutsideLoop

	pop	ebp
	ret	8
SortList ENDP

;************************************************************************
;**						EXCHANGE PROCEDURE
;**
;** Description			: swap two value together
;** Receives			: arrayNumber and many variable form main
;** Returns				: don't return
;** Preconditions		: many should have value between 10 and 200
;** Registers Changed	: ebx,eax,ecx,edx
;**
;*************************************************************************

Exchange PROC
	push ebp
	mov	ebp, esp
	pushad

	mov	ebx, [ebp + 16]				;second number
	mov	eax, [ebp + 12]				;first number
	mov	edx, ebx
	sub	edx, eax	
	
	mov	ecx, [eax]
	mov	ebx, [ebx]
	mov	esi, eax
	mov	[esi], ebx  
	add	esi, edx
	mov	[esi], ecx

	popad
	pop	ebp
	ret	12
Exchange ENDP

;************************************************************************
;**						DisplayMedian PROCEDURE
;**
;** Description			: Calculate and show Median of array number
;** Receives			: arrayNumber and many variable form main
;** Returns				: don't return
;** Preconditions		: many should have value between 10 and 200
;** Registers Changed	: ebx,eax,ecx,edx
;**
;*************************************************************************

DisplayMedian PROC
	push ebp
	mov  ebp, esp
	mov  esi, [ebp + 12]		
	mov	 eax, [ebp + 8]	
	mov  edx, 0
	mov	 ebx, 2
	div	 ebx
	mov	 ecx, eax

	medianLoop:
		add	esi, 4
		loop medianLoop

	; check if remainder is zero
		cmp	edx, 0
		jz EvenNumber

	;OddNumber
		mov	eax, [esi]
		mov	median, eax
		jmp	PrintMedian

	EvenNumber:
		mov	eax, [esi]
		add	eax, [esi-4]
		mov	ebx, 2
		div	ebx
		mov	median,eax
		jmp	PrintMedian
		
	PrintMedian:
		mov	edx, OFFSET output3
		call WriteString
		mov	eax, median
		call WriteDec
		call CrLf
	
	pop  ebp
	ret  8
DisplayMedian ENDP

END main
