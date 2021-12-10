# Expect: 0x80000000

.text
.globl main
main:
    li		$t0,  0xFFFFFFFF
    li		$t1,  0x0000001F 
    sllv $v0, $t0, $t1
    jr $zero

