# Expect: 0xAA

.text
.globl main
main:
    addi    $t1, $t1, 0xAF
    addi    $t2, $t2, 0x5
    subu    $v0, $t1, $t2	
    jr $zero
    