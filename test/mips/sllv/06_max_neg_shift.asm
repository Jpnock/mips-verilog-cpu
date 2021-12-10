# Expect: 0x80000000

.text
.globl main
main:
    la		$t0,  -0xFFFFFFFF
    la		$t1,  0x0000001F
    sllv $v0, $t0, $t1
    jr $zero

