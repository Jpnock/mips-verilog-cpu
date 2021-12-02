# Expected: 0x3
addiu $v1, $v1, 0xFFF1
addiu $v0, $v2, 0xFFFB
div $v1, $v0
jr $ra
sll $zero, $zero, 0
