//Exemplo swap

.data
	vetor: .word 1, 2, 3
	newline: .asciiz"\n"

.text
	//Macro para printar int
	.macro print_int(%REGISTRADOR)
		ADDI X8, XZR, 1
		ADD X7, XZR, %REGISTRADOR
		SVC 0
	.end_macro
	
	.macro	newline
		LDA X7, newline
		ADDI X8, XZR, 4
		SVC 0
	.end_macro
	
	LDA X9, vetor 
	ADDI X15, XZR, 1
	BL SWAP
	
	LDUR X10, [X9, 0] //X10 = X9[0]
	LDUR X11, [X9, 4] //X11 = X9[1]
	LDUR X12, [X9, 8] //X12 = X9[2]  
	
	//Print X9[0]
	print_int(X10)
	newline
	
	//Print X9[1]
	print_int(X11)
	newline
	
	//Print X9[2]
	print_int(X12)
	newline
	
	//Exit
	ADDI X8, XZR, 10
	SVC 0
	
SWAP: //RECEBE O VETOR em X9 e K em X15 , E inverte K elemento com K+1

	LSL X10, X15, 2 //k * 4
	ADD X10, X9, X10//X10 = X9[k]
	
	LDUR X0, [X10, 0] // X0 = k
	LDUR X1, [X10, 4] // X1 = k+1
	
	STUR X0, [X10, 4] // X10[k+1] = TEMP0(X10[k])
	STUR X1, [X10, 0] // X10[k] = TEMP1(X10[K+1])
	
	BR X30
	
	
	
	
