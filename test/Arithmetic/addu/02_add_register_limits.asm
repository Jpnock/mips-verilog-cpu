# Expected: 0xFFFF
addiu $v1, $v1, 0xFFFF
addu $v0, $v0, 0x0
addu $v0, $v1, $v0
jr $ra
sll $zero, $zero, 0