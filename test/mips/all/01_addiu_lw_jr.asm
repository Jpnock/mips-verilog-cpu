# Expect: 0x41424344

.text
.globl main
main:
    lw $t0, var1            # t0   = 0x20A121A4
    addiu $t0, $t0, -1      # t0   = 0x20A121A3
    addiu $t1, $t0, -1      # t1   = 0x20A121A2
    sw $t1, var1            # var1 = 0x20A121A2
    lw $t2, var2            # t2   = 0xFFFFFFFF
    lw $t3, var1            # t3   = 0x20A121A2
    addu $t3, $t3, $t2      # t3   = 0x20A121A1
    addiu $t3, $t3, 1       # t3   = 0x20A121A2
    addu $v0, $t3, $t3      # v0   = 0x41424344
    jr $zero

.data
var1: .word 0x20A121A4
var2: .word 0xFFFFFFFF
