# Expect: 0xffff860c

.text
.globl main
main:
    addi    $t1, $t1, 0x8560
    addi    $t2, $t2, -0xAC
    subu    $v0, $t1, $t2	
    
    jr $zero
