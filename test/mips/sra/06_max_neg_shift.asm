# Expect: 0x0

.text
.globl main
main:
    li		$t0,  -0xFFFFFFFF
    sra $v0, $t0, 0x1F
    jr $zero

