# Expect: -8000


.text
.globl main
main:
	addiu $v0, $v0, -8000
	mtlo $v0
	jr $zero
