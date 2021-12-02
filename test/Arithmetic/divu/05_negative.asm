# Expected: 0x1
addiu $v0, $v0, 0xFFFF
addiu $v1, $v1, 0xFFFF
divu $v0, $v1
jr $ra
sll $zero, $zero, 0
