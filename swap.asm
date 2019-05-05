//Exemplo swap

.data
	vetor: .word 1, 2

.text
	
	LDA X9, vetor 
	BL SWAP
	
	LDUR X10, [X9, 0] //X10 = X9[0]
	LDUR X11, [X9, 4] //X11 = X9[1]
	
	ADDI X8, XZR, 1
	ADD X7, XZR, X10
	SVC 0
	
	ADD X7, XZR, X11
	SVC 0
	
	ADDI X8, XZR, 10
	SVC 0
	
SWAP: //RECEBE O VETOR X9, E inverte o primeiro com o segundo elemento

	LDUR X0, [X9, 0] // X0 = TEMP0
	LDUR X1, [X9, 4] // X1 = TEMP1
	STUR X0, [X9, 4] // X9[1] = TEMP0(X9[0])
	STUR X1, [X9, 0] // X9[0] = TEMP1(X9[1])
	BR X30
	
	
	
	
