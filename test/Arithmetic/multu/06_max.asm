# Expected: 0xFFFE0001
addiu $v0, $v0, 0xFFFF
addiu $v1, $v1, 0xFFFF
multu $v0, $v1
jr $ra
sll $zero, $zero, 0
