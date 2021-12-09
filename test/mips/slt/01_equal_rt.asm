# Expect: 0x00000000

# Test: Ensures rd = 0 when rt = rs. Only works if rs and rt are signed.

.text
.globl main
main:
    addiu $t0, $t0, 0x8000
    addiu $t1, $t1, 0x8000
    slt $v0, $t0, $t1
    jr $zero
