# Expected: 0xFFFF
addiu $v1, $v1, 0xFFFF
addiu $v2, $v2, 0xFFFF
or $v0, $v1, $v2
jr $ra
sll $zero, $zero, 0
