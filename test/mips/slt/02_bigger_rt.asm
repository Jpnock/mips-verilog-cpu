# Expect: 0x00000001

# Test: Ensures rd = 1 when rs < rt. Only works if rs and rt are signed.

.text
.globl main
main:
    addiu $t0, $t0, 0xD69D
    addiu $t1, $t1, 0x0001
    slt $v0, $t0, $t1
    jr $zero
