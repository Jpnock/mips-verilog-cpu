# Expect: 0x0

.text
.globl main
main:
    and $t0, $t1, $t2
    and $v0, $t1, $t0
    jr $zero
