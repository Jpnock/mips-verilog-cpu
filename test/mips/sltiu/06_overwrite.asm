# Expect: 0x00000001

.text
.globl main
main: 
    lw $t1, overwrite
    addu $v0, $v0, $t1
    sltiu $v0, $t0, 0xFFFF
    jr $zero

.data
overwrite: .word 0x6FA1F25F


