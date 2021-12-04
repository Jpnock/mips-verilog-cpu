# Expect: 0x6263646F

.text
.globl main
main:
    la $t0, var1
    addiu $v0, $zero, 0x7F6F
    lwl $v0, 5($t0)
    nop
    lwl $v0, 5($t0)
    nop
    lwl $v0, 5($t0)
    nop
    jr $zero

.data
var1: .word 0x41424344
var2: .word 0x61626364
