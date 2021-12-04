# Expect: -0x8000

.text
.globl main
main:
	addiu $t1, $t1, -0x8000
	mtlo $t1
	mflo $v0
	jr $zero
