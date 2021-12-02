# Expected: 0x8
addiu $v2, $v2, 0x7
addiu $v1, $v1, 0x7
and $v0, $v1, $v2
jr $ra
sll $zero, $zero, 0
