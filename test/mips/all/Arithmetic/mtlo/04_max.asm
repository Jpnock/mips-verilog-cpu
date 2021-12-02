# Expected: 0xFFFF

.text
.globl main
main:
    addiu $v0, $v0, 0xFFFF  
    mtlo $v0
    jr $zero
