# Expect: 0x80000000

.text
.globl main
main:
	addiu $t0, $t0, 0x1F
	sll $v0, $t0, 0x1F
	jr $zero
