TITLE Assignment 6A     (assignment_6A.asm)

; Author: Dat Pham
; Course CS 271 / Project ID          Date: 6/10/2017
; Description: Write a program get unsigned number and calculate sum and average



INCLUDE Irvine32.inc

MIN	= 0
MAX = 10
HIGHER	= 39h
LOWER	= 30h



.data

many				DWORD	10
counter				DWORD	?
stroutput			db 16 dup(0)
array				DWORD MAX DUP(?) 
title1				BYTE			"PROGRAMMING ASSIGNMENT 6: Designing low-level I/O procedures",0
title2				BYTE			"Written by: Dat Pham",0
title3				BYTE			"Please provide 10 unsigned decimal integers.",0
title4				BYTE			"Each number needs to be small enough to fit inside a 32 bit register.",0
title5				BYTE			"After you have finished inputting the raw numbers I will display a list",0
title6				BYTE			"of the integers, their sum, and their average value.",0

input1				BYTE			"Please enter an unsigned number: ",0
input2				BYTE			"Please try again: ",0
error				BYTE			"ERROR: You didnot enter an unsigned number or your number was too big",0

output1				BYTE			"You entered the following numbers: ",0
output2				BYTE			"The sum of these numbers is: ",0
output3				BYTE			"The average is: ",0
output4				BYTE			"Thanks for playing!",0
spaces				BYTE			"    ",0
			

displayString MACRO  stroutput

	push edx
	mov	 edx, stroutput
	call WriteString
	pop	 edx

ENDM

getString MACRO	input1, many, counter
	
	push eax
	push ebx
	push ecx
	push edx

	mov	 edx, OFFSET input1
	call WriteString
	mov	 edx, OFFSET many		;address of many
	mov	 ecx, SIZEOF many		;max number of character
	dec  ecx					;leave space for zero
	call ReadString				;input string
	mov	 counter, 00000000h
	mov	 counter, eax			;save the length
	
	pop	 edx
	pop	 ecx
	pop  ebx
	pop  eax
	

ENDM



.code
main PROC

;call introduction
call Introduction;

;read value 
push OFFSET array
push OFFSET many
push OFFSET counter
call readVal
call	CrLf

;Display array of number
push	OFFSET stroutput
push	OFFSET array
call	writeVal
call	CrLf

;Display sum and average of array
push	OFFSET output3
push	OFFSET output2
push	OFFSET array
call	displaySum
call	CrLf
call	CrLf

;Display end 
mov		 edx, OFFSET output4			
call	 WriteString
call	 CrLf

exit
main ENDP



;**********************************************************************************************
;**									INTRODUCTION PROCEDURE
;**
;** Description		  : Display assignment information of program 6	 
;** Preconditions	  : title1, title2, title3, title4, title5, title6 should be set to strings data type
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
	call	 CrLf

	mov		edx, OFFSET title3			;line 3
	call	WriteString
	call	 CrLf

	mov		edx, OFFSET title4			;line 4
	call	WriteString
	call	CrLf

	mov		edx, OFFSET title5			;line 5
	call	WriteString
	call	CrLf

	mov		edx, OFFSET title6			;line 6
	call	WriteString
	call	CrLf
	call	CrLf
	ret

introduction ENDP

;*************************************************************************
;**							READVAL PROCEDURE
;**
;** Description		  : Function will get value from user and conver into a string.
;** Preconditions	  :	declare an array, and way count number that entered
;** Receives		  : array will save values in
;** Registers Changed : edx, eax, ecx, ebx
;** Returns			  :	return user's integers into an array of strings
;**
;*************************************************************************

readVal PROC

		push  ebp
		mov	  ebp, esp			
		mov	  edi, [ebp+16]							
		mov	  ecx, 10
	EnterNumber: 	
					
		getString input1, many, counter   
		push ecx
		mov	esi, [ebp+12]		
		mov	ecx, [ebp+8]			
		mov	ecx, [ecx]			
		cld			
		sub	ebx, ebx			;clear register
		sub	eax, eax		    ;clear register
		
			StringInt:
				
				lodsb							
				cmp	 eax, LOWER			
				jb	 ErrorMess		
				cmp	 eax, HIGHER			
				ja	 ErrorMess		
							
				sub	 eax, LOWER		
				push eax			;push eax to stack
				mov	 eax, ebx
				mov	 ebx, MAX
				mul	 ebx
				mov	 ebx, eax
				pop	 eax
				add	 ebx, eax
				mov	 eax, ebx
							
				sub	 eax, eax		;clear eax
				loop StringInt

				mov	 eax,ebx 
				stosd						
					
				add	 esi, 4			;next element
				pop  ecx						
				loop EnterNumber
				jmp	 EndPro
		
		ErrorMess:
				pop	 ecx
				mov	 edx, OFFSET  error
				call WriteString
				call CrLf
				jmp	 EnterNumber

	EndPro:
		pop ebp			
		ret 12										
											
readVal ENDP



;************************************************************************
;**						WRITEVAL PROCEDURE
;**
;** Description			: convert to strings to ascii and prints it out
;** Receives			: array of element, many: number of array element
;** Returns				: don't return
;** Preconditions		: have an array of integers as strings
;** Registers Changed	: eci,eax,ebx.ecx
;**
;*************************************************************************

writeVal PROC
	
	;Display string output
	push	edx
	mov		edx, OFFSET output1
	call	WriteString
	pop		edx
	call	CrLf

	;Display array number
	push ebp
	mov	 ecx,10
	mov	 ebp,esp
	mov	 edi,[ebp + 8]

	WriteLoop:	
		push ecx
		mov	 ecx,10   
		mov	 eax,[edi]
		xor	 ebx,ebx            ;register count number of digit

		DivideFun:
			xor	 edx, edx				
			div	 ecx						
			push edx						 
			add	 ebx,1			;add 1 number of digit			  
			cmp  eax,0				
			jnz	 DivideFun					 
								 
		mov	 ecx, ebx					 
		lea	 esi, stroutput		
			
		Next_Number:
			pop	 eax
			add	 eax,'0'					 
			mov	 [esi], eax				 
				
			displayString OFFSET stroutput
			loop Next_Number
			
		pop	 ecx 
		mov	 edx,OFFSET spaces
		call WriteString
		add	 edi, 4				;next element
		loop WriteLoop
	
	pop	ebp			
	ret	8										
writeVal ENDP


;************************************************************************
;**						DISPLAYSUM PROCEDURE
;**
;** Description			: sum value and calculate average
;** Receives			: array number 
;** Returns				: don't return
;** Preconditions		: Array have 10 element
;** Registers Changed	: ebx,eax,ecx,edx
;**
;*************************************************************************

displaySum PROC

	sub	 ebx, ebx
	sub  edx, edx
	mov	 eax, 10									
	mov	 ecx, eax

	push ebp
	mov  ebp, esp
	mov  esi, [ebp + 8]  
	
	SumLoop:
		mov	 eax, [esi]
		add	 ebx, eax
		add	 esi, 4
		loop SumLoop

   mov ecx,0
;Display sum
DisplaySumNum:
	mov	 edx,0
	mov	 edx,[ebp+12]
	mov	 eax,ebx
	jmp WriteToString
	
;Display average
DisplayAver:
	mov ecx,1
	mov	 edx, 0
	mov	 ebx, 10
	div	 ebx
	mov	 edx, [ebp+16]
	
    WriteToString:
		call WriteString
		call WriteDec
		call CrLf
		cmp ecx,0
		jz DisplayAver

	pop	ebp
	ret	12
displaySum ENDP

END main
