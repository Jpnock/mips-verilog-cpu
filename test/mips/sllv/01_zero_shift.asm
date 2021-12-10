# Expect: 0x12

.text
.globl main
main:
    addiu $t0, $t0, 0x12
    sllv $v0, $t0, $t1
    jr $zero 
