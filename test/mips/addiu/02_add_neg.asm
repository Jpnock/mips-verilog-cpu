# Expect: -0x260

.text
.globl main
main:
    addiu $t0, $t0, -0x21F
    addiu $v0, $t0, -0x41  
    jr $zero
