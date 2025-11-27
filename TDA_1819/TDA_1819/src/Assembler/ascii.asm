		.data
num2:		.hword	2
num1:		.word	20
		.code
		lh r7, num2(r0)
		daddi r8, r7, 0
		pushh r8
		pushh r8
		poph r8
		poph r8
		halt
  