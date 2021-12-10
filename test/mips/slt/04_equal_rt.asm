# Expect: 0X00000000

# Test: Ensures rd = 0 when rt = rs; rt and rs are loaded from memory.

.text
.globl
main:
    lw $t0, rt
    lw $t1, rs
    slt $v0, $t1, $t0
    jr $zero

    
.data
rt: .word 0xFFFF0000
rs: .word 0xFFFF0000
