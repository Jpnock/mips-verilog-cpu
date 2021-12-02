# Expected: 0x5 However it is unsigned so not sure if it'll work
addiu $v0, $v0, 0x6
addiu $v0, $v0, 0xFFFF
jr $ra
sll $zero, $zero, 0
