.data
	bemvindo: .asciiz "Equacao no formato: ax²+bx+c\n"
	digite1: .asciiz "Informe o 'a'\n"
	digite2: .asciiz "Informe o 'b'\n"	
	digite3: .asciiz "Informe o 'c'\n"
	delta: .asciiz "Delta = "
	newline: .asciiz "\n"
	deltapositivo: .asciiz "A equacao possui duas raizes reais\n"
	deltazero: .asciiz "A equação possui somente uma raiz real\n"
	deltanegativo: .asciiz "A equacao possui duas raizes imaginarias\n"
	
.text
	
//Desenvolvido por:
//-Gabriel Santos	github.com/salanho
//-Carlos Gabriel Soares github.com/gabuvns


//////////////////////////////////////////////////////////////////////////
//REALIZA O PUSH DE 1 REGISTRADOR NA PILHA (X28)	
	.macro push_1 (%REGISTRADOR)				
		SUBI X28, X28, 8				
		STUR %REGISTRADOR, [X28, 8]			
	.end_macro		
							
//----------------------------------------------------------------------//
//REALIZA O POP DE 1 REGISTRADOR NA PILHA (X28)	
	.macro pop_1 (%REGISTRADOR)				
		LDUR %REGISTRADOR, [X28, 8]			
		SUBI X28, X28, 8				
	.end_macro						
	
//----------------------------------------------------------------------//
//PRINTA O NUMERO ESCOLHIDO PELO REGISTRADOR	
	
	.macro print_int (%REGISTRADOR)					
		ADD X7, %REGISTRADOR, XZR				
		ADDI X8, XZR, 1						
		SVC 0 						
	.end_macro
								
//----------------------------------------------------------------------//
//PRINTA A LABEL ESCOLHIDA PELO REGISTRADOR	
	.macro print_lb (%LABEL)				
		LDA X7, %LABEL					
		ADDI X8, XZR, 4					
		SVC 0						
	.end_macro	
						
//----------------------------------------------------------------------//
//PEGA INT DO USUARIO, ARMAZENADO EM X2		
	.macro get_int						
		ADDI X8, XZR, 5						
		SVC 0						
	.end_macro	
						
//----------------------------------------------------------------------//
//FINALIZA O PROGRAMA 				
	.macro exit						
		ADDI X8, XZR, 10				
		SVC 0						
	.end_macro
							
//////////////////////////////////////////////////////////////////////////

	MAIN:
		print_lb(bemvindo)
		
		print_lb(digite1)
		get_int
		ADD X0, X2, XZR // X0 = input 1 (a)
		
		print_lb(digite2)
		get_int
		ADD X1, X2, XZR // X1 = input 2	(b)
		
		print_lb(digite3)
		get_int
		ADD X3, X2, XZR // X3 = input 3(c) 
		BL BHASKARA
			
		exit
		
	BHASKARA: //recebe a, b e c
		ADDI X10, XZR, 0
		MUL X4, X1, X1 // X4 = b*b
		ADDI X5, XZR, 4 //X5 = 4
		MUL X6, X0, X5 // X6 = 4*a   OBSERVAMOS QUE X7 E X8 SAO RESERVADOS 
		MUL X9, X6, X3// X9 = 4ac
		SUBS X10, X4, X9 //X10 = b²-4ac , alem de setar as flags para comparacao
		print_lb(delta)
		print_int(X10)
		print_lb(newline)
		CBZ X10, DELTAZERO
		B.MI DELTANEGATIVO
		B.PL DELTAPOSITIVO
		
		BR X30
		
	DELTAPOSITIVO:
			print_lb(deltapositivo)
			BR X30
	DELTANEGATIVO:
			print_lb(deltanegativo)
			BR X30
	DELTAZERO:
			print_lb(deltazero)
			BR X30