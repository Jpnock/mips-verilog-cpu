# Expected: 0x34
addiu $v1, $v1, 0x2D
addiu $v0, $v0, 0x19
xor $v0, $v0, $v1
jr $ra
sll $zero, $zero, 0

