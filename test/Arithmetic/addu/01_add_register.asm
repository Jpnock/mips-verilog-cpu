# Expected: 0xA
addiu $v1, $v1, 0x5
addu $v0, $v1, $v2
addu $v0, $v1, $v0
addu $v2, $v1, $v0
jr $ra
sll $zero, $zero, 0
