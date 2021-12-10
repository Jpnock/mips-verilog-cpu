# Expect: 0xFFFFFFFF

.text
.globl main
main:
    la		$t0,  0xFFFFFFFF
    sra $v0, $t0, 0x1F
    jr $zero
