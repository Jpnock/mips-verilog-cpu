# Expect: 0x7FFF

.text
.globl main
main:
    addiu $v0, $v0, 0x7FFF 
    mtlo $v0
    jr $zero
