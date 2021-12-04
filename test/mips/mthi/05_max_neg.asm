# Expect: -0x8000

.text
.globl main
main:
	addiu $t1, $t1, -0x8000
	mthi $t1
	mfhi $v0
	jr $zero
