# Expect: 0x00000001

.text
.globl main
main: 
    addiu $t1, $t1, 0x000F
    addiu $t0, $t0, 0x0009
    sltu $v0, $t0, $t1
    jr $zero


