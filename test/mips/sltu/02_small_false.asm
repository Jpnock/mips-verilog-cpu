# Expect: 0x0000000A

.text
.globl main
main: 
    addiu $t1, $t1, 0x000F
    addiu $t0, $t0, 0x0009
    sltu $v0, $t1, $t0
    addiu $v0, $v0, 0x000A
    jr $zero


