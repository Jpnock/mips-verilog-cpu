# Expected: 0xFFFF
    
.text
.globl main
main:    
    addiu $v0, $v0, 0xFFFF
    addiu $t1, $t1, 0x1
    divu $v0, $t1
    jr $zero
