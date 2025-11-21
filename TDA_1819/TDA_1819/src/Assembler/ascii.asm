		.data
num2:		.hword	80
num1:		.word	20
		.code
		lw r1, num1(r0)
		daddi r3, r2, 5
		addf f3, f1, f2
		pushh rd
		halt
	