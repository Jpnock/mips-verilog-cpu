# Expected: 0x? Shouldn't work: x/0
addiu $v1, $v1, 0xFFFF
div $v1, $v0
jr $ra
sll $zero, $zero, 0
