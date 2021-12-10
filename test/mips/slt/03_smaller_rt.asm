# Expect: 0x00000000

# Test: Ensures rd = 0 when rs > rt. Only works if rs and rt are signed.

.text
.globl main
main:
    addiu $t0, $t0, 0x5000
    addiu $t1, $t1, 0x8DFF
    slt $v0, $t0, $t1
    jr $zero
