# Expect: 0x000017E61

.text
.globl main
main:
    la $t0, var2
    addiu $v0, $v0, 0x7F6F
    addiu $v0, $v0, 0x7F6F
    addiu $v0, $v0, 0x7F6F  # 0x17E4D
    lwr $v0, 0($t0)
    nop
    jr $zero

.data
var1: .word 0x41424344
var2: .word 0x61626364
