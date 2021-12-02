# Expected: 0xFFF60019
addiu $v0, $v0, 0xFFFB
addiu $v1, $v1, 0xFFFB
multu $v0, $v1
jr $ra
sll $zero, $zero, 0
