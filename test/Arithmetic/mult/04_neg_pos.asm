# Expected: 0xFFE7
addiu $v0, $v0, 0x5
addiu $v1, $v1, 0xFFFB
mult $v0, $v1
jr $ra
sll $zero, $zero, 0
