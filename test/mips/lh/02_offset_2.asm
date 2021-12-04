# Expect: 0x4344

.text
.globl main
main:
    la $t0, var1
    lh $v0, 2($t0)
    jr $zero

.data
var1: .word 0x41424344
