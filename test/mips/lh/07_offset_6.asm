# Expect: 0xFFFF8384

.text
.globl main
main:
    la $t0, var1
    lh $v0, 6($t0)
    jr $zero
.data
    var1: .word 0x41424344
    var2: .word 0x81828384
