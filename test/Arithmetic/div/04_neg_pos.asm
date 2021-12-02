# Expected: 0xFFFB
addiu $v1, $v1, 0xFFF1
addiu $v0, $v2, 0x5
div $v1, $v0
jr $ra
sll $zero, $zero, 0
