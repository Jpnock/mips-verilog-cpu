# Expect: -0x260

.text
.globl main
main:
    addiu $v0, $v0, -0x21F
    addiu $v0, $v0, -0x41  
    jr $zero
