# Expected: 0x0
addiu $v1, $v1, 0xFFFF
addiu $v0, $v0, 0xFFFF
xor $v0, $v0, $v1
jr $ra
sll $zero, $zero, 0
