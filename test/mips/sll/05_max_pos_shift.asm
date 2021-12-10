# Expect: 0x80000000

.text
.globl main
main:
    la		$t0,  0xFFFFFFFF
    sll $v0, $t0, 0x1F
    jr $zero

