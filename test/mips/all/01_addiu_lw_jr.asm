# Expect: 0x41424342

.text
.globl main
main:
    lw $t0, var1
    addiu $t0, $t0, -1
    addiu $v0, $t0, -1
    jr $zero

.data
var1: .word 0x41424344
