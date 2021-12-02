# Expected: 0x0
addiu $v1, $v1, 0xFFFF
xori $v0, $v1, 0xFFFF
jr $ra
sll $zero, $zero, 0
