# Expected: 0xFFFB

.text
.globl main
main:
    addiu $t1, $t1, 0xFFF1  
    addiu $v0, $t2, 0x5
    div $t1, $v0
    jr $zero
    