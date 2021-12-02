# Expected: 0x3
addiu $v0, $v0, 0xF
addiu $v1, $v1, 0x5
divu $v0, $v1
jr $ra
sll $zero, $zero, 0
