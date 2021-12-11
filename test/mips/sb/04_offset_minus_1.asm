# Expect: 0x41424388

.text
.globl main
main:
    lw $t0, var2
    la $t1, var2
    sb $t0, -1($t1)
    lw $v0, var1
    jr $zero

.data
    var1: .word 0x41424344
    var2: .word 0x85868788
